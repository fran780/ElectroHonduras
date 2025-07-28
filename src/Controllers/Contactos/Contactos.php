<?php
namespace Controllers\Contactos;

use Controllers\PublicController;
use Views\Renderer;
use Utilities\Site;

class Contactos extends PublicController
{
    public function run(): void
    {
        $viewData = [];

        Site::addLink("public/css/contacto.css");

        Renderer::render("contactos/contactos", $viewData);
    }
}