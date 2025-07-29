<?php

namespace Controllers;

use Utilities\Site;
use Views\Renderer;

class BasicInfo extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/basicinfo.css");

        $viewData = [
            "historia" => "ElectroHonduras nace en 2020 como una respuesta directa a la creciente necesidad de acceso a productos electrónicos de calidad en Honduras. En ciudades en desarrollo como Taulabé, notamos que encontrar tecnología confiable a buen precio era todo un reto para muchas familias. Por eso decidimos crear una alternativa accesible, moderna y centrada en el cliente.

            Desde nuestros inicios, nuestra meta ha sido facilitar el acceso a dispositivos tecnológicos sin que las personas tengan que desplazarse a las grandes ciudades. A través de nuestra plataforma digital, ofrecemos una variedad de productos, desde computadoras y televisores, hasta teléfonos móviles y dispositivos para el hogar, con entregas seguras a todo el país.

            Hoy, después de varios años de trabajo, ElectroHonduras se ha consolidado como una de las principales tiendas electrónicas en línea del país. Nuestro enfoque en la atención al cliente, la confianza y la entrega oportuna nos ha permitido crecer junto a comunidades como Taulabé, aportando al desarrollo local mediante el acceso a la tecnología.",

            "mision" => "Nuestra misión es facilitar el acceso a la tecnología en todo Honduras, ofreciendo productos electrónicos modernos, funcionales y confiables a precios accesibles. Creemos que la tecnología debe estar al alcance de todos, sin importar si viven en ciudades grandes o en comunidades en crecimiento como Taulabé. Por eso, trabajamos cada día para ofrecer una experiencia de compra en línea segura, ágil y respaldada por un servicio al cliente atento, cercano y comprometido con las necesidades reales de nuestros usuarios.",

            "vision" => "Aspiramos a consolidarnos como la tienda electrónica de referencia en Honduras, reconocida por ofrecer productos de calidad y por nuestro compromiso con la innovación, la inclusión digital y el servicio al cliente. Queremos ser ese aliado confiable que acerque la tecnología a todos los rincones del país, desde las grandes ciudades hasta comunidades en desarrollo, contribuyendo así al crecimiento y modernización de nuestra sociedad.",

           "valores" => "• Compromiso con el cliente: entendemos las necesidades reales de quienes confían en nosotros y respondemos con atención, respeto y soluciones prácticas.\n• Transparencia: ofrecemos precios claros, procesos sencillos y condiciones justas, sin letras pequeñas.\n• Innovación: nos mantenemos al día con la tecnología, ofreciendo productos útiles, actuales y pensados para el contexto hondureño.\n• Accesibilidad: llegamos a todo el país, incluyendo zonas en crecimiento, porque creemos que todos deben tener acceso a la tecnología.\n• Responsabilidad: actuamos con ética en cada decisión, cuidando nuestro impacto comercial, social y ambiental."
        ];

        Renderer::render("basicinfo", $viewData);
    }
}