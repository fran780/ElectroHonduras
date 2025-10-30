<?php
namespace Controllers;

use Controllers\PublicController;
use Utilities\Site;
use Views\Renderer;

class Faq extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/faq.css");
        Renderer::render("faq", []);
    }
}