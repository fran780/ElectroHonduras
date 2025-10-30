<?php

namespace Controllers\Contactos;

use Controllers\PublicController;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

class Contacto extends PublicController
{
    private $viewData = [];
    private $formData = [
        "txtNombre" => "",
        "txtApellido" => "",
        "txtCorreo" => "",
        "txtTelefono" => "",
        "txtMen" => ""
    ];
    private $errors = [];
    private $xssToken = "";

    public function run(): void
    {
        $this->xssToken = md5("CONTACTO_XSS_TOKEN" . date("Ymdhisu"));
        $this->viewData["xssToken"] = $this->xssToken;

        if ($this->isPostBack()) {
            $this->mapFormData();
            if ($this->validateForm()) {
                Site::redirectToWithMsg("index.php?page=Contactos_Contactos", "Mensaje enviado con éxito.");
                return;
            }
        }

        $this->viewData["form"] = $this->formData;
        $this->viewData["errors"] = $this->errors;
        Renderer::render("contactos/contactos", $this->viewData);
    }

    private function mapFormData(): void
    {
        $this->xssToken = $_POST["xssToken"] ?? "";
        $this->formData["txtNombre"] = $_POST["txtNombre"] ?? "";
        $this->formData["txtApellido"] = $_POST["txtApellido"] ?? "";
        $this->formData["txtCorreo"] = $_POST["txtCorreo"] ?? "";
        $this->formData["txtTelefono"] = $_POST["txtTelefono"] ?? "";
        $this->formData["txtMen"] = $_POST["txtMen"] ?? "";
    }

    private function validateForm(): bool
    {
        if (Validators::IsEmpty($this->formData["txtNombre"])) {
            $this->errors["txtNombre_error"] = "El nombre es obligatorio.";
        }

        if (Validators::IsEmpty($this->formData["txtApellido"])) {
            $this->errors["txtApellido_error"] = "El apellido es obligatorio.";
        }

        if (!Validators::IsValidEmail($this->formData["txtCorreo"])) {
            $this->errors["txtCorreo_error"] = "Correo inválido.";
        }

        if (!Validators::IsValidHonduranCelPhone($this->formData["txtTelefono"])) {
            $this->errors["txtTelefono_error"] = "Teléfono inválido (ej: 1234-5678).";
        }

        if (Validators::IsEmpty($this->formData["txtMen"])) {
            $this->errors["txtMen_error"] = "Debe escribir un mensaje.";
        }

        return count($this->errors) === 0;
    }
}