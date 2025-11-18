<?php

namespace Controllers\Usuarios;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Usuarios\Usuarios as UsuariosDao;
use Utilities\Security;
use Utilities\Site;
use Utilities\Validators;

class Usuario extends PrivateController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de %s %s",
        "INS" => "Nuevo Usuario",
        "UPD" => "Editar %s %s",
        "DEL" => "Eliminar %s %s"
    ];
    private $readonly = "";
    private $showCommitBtn = true;
    private $usuario = [
        "usercod" => 0,
        "username" => "",
        "useremail" => "",
        "userest" => "ACT"
    ];
    private $roles = [];
    private $originalRoles = [];
    private $isEditingSelf = false;
    private $availableRoles = [];
    private $rolesError = "";
    private $usuario_xss_token = "";

    public function run(): void
    {
        try {
            $this->getData();
            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handlePostAction();
                }
            }
            $this->setViewData();
            Renderer::render("usuarios/usuario", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Usuarios_Usuarios",
                $ex->getMessage()
            );
        }
    }

    private function getData()
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (isset($this->modeDescriptions[$this->mode])) {
            $requestedUserId = intval($_GET["usercod"] ?? 0);
            if ($this->mode === "DEL" && $requestedUserId === Security::getUserId()) {
                Site::redirectToWithMsg(
                    "index.php?page=Usuarios_Usuarios",
                    "No puede eliminar su propia cuenta"
                );
                return;
            }
            $this->readonly = ($this->mode === "DEL" || $this->mode === "DSP") ? "readonly" : "";
            $this->showCommitBtn = $this->mode !== "DSP";
            if ($this->mode !== "INS") {
                $this->usuario = UsuariosDao::getUsuarioById($requestedUserId);
                if (!$this->usuario) {
                    throw new \Exception("No se encontró el Usuario", 1);
                }
                $this->roles = UsuariosDao::getActiveRoleCodesForUser($this->usuario["usercod"]);
                if (count($this->roles) > 1) {
                    $this->roles = array_slice($this->roles, 0, 1);
                }
                $this->roles = UsuariosDao::getActiveRoleCodesForUser($this->usuario["usercod"]);
                if (count($this->roles) > 1) {
                    $this->roles = array_slice($this->roles, 0, 1);
                }
                $this->originalRoles = $this->roles;
                $this->isEditingSelf = ($this->usuario["usercod"] === Security::getUserId());
            }
        } else {
            throw new \Exception("Formulario cargado en modalidad invalida", 1);
        }
        $this->availableRoles = UsuariosDao::getActiveRoles();
        if ($this->mode === "INS" && count($this->roles) === 0) {
            foreach ($this->availableRoles as $role) {
                if ($role["rolescod"] === "CLI") {
                    $this->roles[] = "CLI";
                    break;
                }
            }
        }
    }

    private function validateData()
    {
        if ($this->mode === "DEL") {
            $this->usuario["usercod"] = intval($_POST["usercod"] ?? "");
            return true;
        }

        $errors = [];
        $this->usuario_xss_token = $_POST["usuario_xss_token"] ?? "";
        $this->usuario["usercod"] = intval($_POST["usercod"] ?? "");
        $this->usuario["username"] = trim(strval($_POST["username"] ?? ""));
        $this->usuario["username"] = preg_replace('/\s+/', ' ', $this->usuario["username"]);
        $this->usuario["useremail"] = strval($_POST["useremail"] ?? "");
        $this->usuario["userest"] = strval($_POST["userest"] ?? "");
        $rolesInput = $_POST["roles"] ?? "";
        $rolesErrors = [];

        if (is_array($rolesInput)) {
            $rolesInput = array_values(array_filter(array_map("strval", $rolesInput)));
            if (count($rolesInput) > 1) {
                $rolesErrors[] = "Solo puede seleccionar un rol";
            }
            $rolesInput = $rolesInput[0] ?? "";
        }

        $rolesInput = strval($rolesInput);

        $validRoles = array_column($this->availableRoles, "rolescod");

        if ($rolesInput !== "" && !in_array($rolesInput, $validRoles)) {
            $rolesInput = "";
        }

        $this->roles = $rolesInput !== "" ? [$rolesInput] : [];

        if ($this->mode === "UPD" && $this->isEditingSelf && in_array("ADMIN", $this->originalRoles)) {
            if ($rolesInput !== "ADMIN") {
                $rolesErrors[] = "Su cuenta debe conservar el rol Administrador";
                $this->roles = ["ADMIN"];
            }
        }

        if (Validators::IsEmpty($this->usuario["username"])) {
            $errors["username_error"] = "El nombre de usuario es requerido";
        } elseif (!Validators::IsValidHumanName($this->usuario["username"])) {
            $errors["username_error"] = "El nombre debe tener al menos 3 letras y solo puede incluir letras, espacios, guiones o apóstrofes.";
        }

        if (Validators::IsEmpty($this->usuario["useremail"])) {
            $errors["useremail_error"] = "El correo del usuario es requerido";
        } elseif (!Validators::IsValidEmail($this->usuario["useremail"])) {
            $errors["useremail_error"] = "El correo del usuario no tiene un formato válido";
        }

        $existingUser = UsuariosDao::getUsuarioByEmail($this->usuario["useremail"]);
        if ($existingUser && intval($existingUser["usercod"]) !== $this->usuario["usercod"]) {
            $errors["useremail_error"] = "Ya existe un usuario con este correo";
        }

        if (!in_array($this->usuario["userest"], ["ACT", "INA"])) {
            $errors["userest_error"] = "El estado del usuario es inválido";
        }

        if (empty($rolesErrors) && count($validRoles) > 0 && count($this->roles) === 0) {
            $rolesErrors[] = "Debe seleccionar un rol";
        }

        if (!empty($rolesErrors)) {
            $errors["roles_error"] = implode(". ", array_unique($rolesErrors));
        }


        if (count($errors) > 0) {
            foreach ($errors as $key => $value) {
                $this->usuario[$key] = $value;
            }
            $this->rolesError = $errors["roles_error"] ?? "";
            return false;
        }
        $this->rolesError = "";
        return true;
    }

    private function handlePostAction()
    {
        switch ($this->mode) {
            case "INS":
                $this->handleInsert();
                break;
            case "UPD":
                $this->handleUpdate();
                break;
            case "DEL":
                $this->handleDelete();
                break;
            default:
                throw new \Exception("Modo invalido", 1);
        }
    }

    private function handleInsert()
    {
        $usercod = UsuariosDao::insertUsuario(
            $this->usuario["username"],
            $this->usuario["useremail"],
            $this->usuario["userest"]
        );

        if ($usercod <= 0) {
            throw new \Exception("No se pudo crear el usuario", 1);
        }
        UsuariosDao::syncUsuarioRoles($usercod, $this->roles);
        Site::redirectToWithMsg(
            "index.php?page=Usuarios_Usuarios",
            "Usuario creado exitosamente"
        );
    }

    private function handleUpdate()
    {
        $result = UsuariosDao::updateUsuario(
            $this->usuario["usercod"],
            $this->usuario["username"],
            $this->usuario["useremail"],
            $this->usuario["userest"]
        );
        if (!$result) {
            throw new \Exception("No se pudo actualizar el usuario", 1);
        }
        UsuariosDao::syncUsuarioRoles($this->usuario["usercod"], $this->roles);
        Site::redirectToWithMsg(
            "index.php?page=Usuarios_Usuarios",
            "Usuario actualizado exitosamente"
        );
    }

    private function handleDelete()
    {
        $loggedUserId = Security::getUserId();
        if ($this->usuario["usercod"] == $loggedUserId) {
            Site::redirectToWithMsg(
                "index.php?page=Usuarios_Usuarios",
                "No puede eliminar su propia cuenta"
            );
            return;
        }
        $result = UsuariosDao::deleteUsuario($this->usuario["usercod"]);
        if ($result > 0) {
            Site::redirectToWithMsg(
                "index.php?page=Usuarios_Usuarios",
                "Usuario Eliminado exitosamente"
            );
        }
    }

    private function setViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["usuario_xss_token"] = $this->usuario_xss_token;
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->usuario["usercod"],
            $this->usuario["username"]
        );
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["readonly"] = $this->readonly;

        $userestKey = "userest_" . strtolower($this->usuario["userest"]);
        $this->usuario[$userestKey] = "selected";

        $this->viewData["usuario"] = $this->usuario;

        $disableRoles = ($this->mode === "DSP" || $this->mode === "DEL");
        $lockAdminRole = $this->isEditingSelf && in_array("ADMIN", $this->originalRoles);
        $rolesForView = array_map(function ($role) use ($disableRoles, $lockAdminRole) {
            $shouldDisable = $disableRoles || ($lockAdminRole && $role["rolescod"] !== "ADMIN");
            return [
                "rolescod" => $role["rolescod"],
                "rolesdsc" => $role["rolesdsc"],
                "checked" => in_array($role["rolescod"], $this->roles) ? "checked" : "",
                "rolesDisabledAttr" => $shouldDisable ? "disabled" : ""
            ];
        }, $this->availableRoles);

        $this->viewData["roles"] = $rolesForView;
        $this->viewData["hasRoles"] = count($rolesForView) > 0;
        if ($this->rolesError !== "") {
            $this->viewData["roles_error"] = $this->rolesError;
        }
    }
}
