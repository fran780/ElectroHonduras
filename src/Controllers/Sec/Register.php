<?php

namespace Controllers\Sec;

use Controllers\PublicController;
use \Utilities\Validators;
use Exception;

class Register extends PublicController
{
    private $txtEmail = "";
    private $txtPswd = "";
    private $txtNombre = "";
    private $txtApellido = "";
    private $errorEmail = "";
    private $errorPswd = "";
    private $errorNombre = "";
    private $errorApellido = "";
    private $hasErrors = false;
    public function run(): void
    {

        if ($this->isPostBack()) {
            $this->txtEmail = trim($_POST["txtEmail"] ?? "");
            $this->txtPswd = trim($_POST["txtPswd"] ?? "");
            $this->txtNombre = trim($_POST["txtNombre"] ?? "");
            $this->txtApellido = trim($_POST["txtApellido"] ?? "");
            $this->txtNombre = preg_replace('/\s+/', ' ', $this->txtNombre);
            $this->txtApellido = preg_replace('/\s+/', ' ', $this->txtApellido);
            //validaciones
            if (!(Validators::IsValidEmail($this->txtEmail))) {
                $this->errorEmail = "El correo no tiene el formato adecuado";
                $this->hasErrors = true;
            }
              if (
                Validators::IsValidEmail($this->txtEmail) &&
                \Dao\Security\Security::getUsuarioByEmail($this->txtEmail)
            ) {
                $this->errorEmail = "El correo ya se encuentra registrado";
                $this->hasErrors = true;
            }
            if (!Validators::IsValidPassword($this->txtPswd)) {
                $this->errorPswd = "La contraseña debe tener al menos 8 caracteres una mayúscula, un número y un caracter especial.";
                $this->hasErrors = true;
            }
            if (Validators::IsEmpty($this->txtNombre)) {
                $this->errorNombre = "El nombre es obligatorio.";
                $this->hasErrors = true;
            } elseif (!Validators::IsValidHumanName($this->txtNombre)) {
                $this->errorNombre = "El nombre debe tener al menos 3 letras y solo puede incluir letras, espacios, guiones o apóstrofes.";
                $this->hasErrors = true;
            }
            if (Validators::IsEmpty($this->txtApellido)) {
                $this->errorApellido = "El apellido es obligatorio.";
                $this->hasErrors = true;
            } elseif (!Validators::IsValidHumanName($this->txtApellido)) {
                $this->errorApellido = "El apellido debe tener al menos 3 letras y solo puede incluir letras, espacios, guiones o apóstrofes.";
                $this->hasErrors = true;
            }

            if (!$this->hasErrors) {
                try {
                    if (\Dao\Security\Security::newUsuario($this->txtEmail, $this->txtPswd, $this->txtNombre, $this->txtApellido)) {
                        \Utilities\Site::redirectToWithMsg("index.php?page=sec_login", "¡Usuario Registrado Satisfactoriamente!");
                    }
                } catch (\Error $ex) {
                    die($ex);
                }
            }
        }
        $viewData = get_object_vars($this);
        \Views\Renderer::render("security/sigin", $viewData);
    }
}
