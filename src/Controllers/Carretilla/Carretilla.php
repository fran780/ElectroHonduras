<?php

namespace Controllers\Carretilla;

use Controllers\PublicController;
use Dao\Cart\Cart;
use Utilities\Cart\CartFns;
use Utilities\Site;

class Carretilla extends PublicController
{
    public function run(): void
    {
        Site::addLink("public/css/products.css");
        $viewData = [];

        // En esta fase estara todo público, por lo tanto se usa solo la carretilla anónima
        $anonCod = CartFns::getAnnonCartCode();
        $carretilla = Cart::getAnonCart($anonCod);

        if ($this->isPostBack()) {
            if (isset($_POST["removeOne"]) || isset($_POST["addOne"])) {
                $productId = intval($_POST["productId"]);
                $productoDisp = Cart::getProductoDisponible($productId);
                $amount = isset($_POST["removeOne"]) ? -1 : 1;

                if ($amount === 1) {
                    if ($productoDisp["productStock"] - $amount >= 0) {
                        Cart::addToAnonCart(
                            $productId,
                            $anonCod,
                            $amount,
                            $productoDisp["productPrice"]
                        );
                    }
                } else {
                    Cart::addToAnonCart(
                        $productId,
                        $anonCod,
                        $amount,
                        $productoDisp["productPrice"]
                    );
                }

                $carretilla = Cart::getAnonCart($anonCod);
                $this->getCartCounter();
            }
            Site::redirectTo("index.php?page=Carretilla_Carretilla");
        }

        $finalCarretilla = [];
        $counter = 1;
        $total = 0;

        foreach ($carretilla as $prod) {
            $prod["row"] = $counter;
            $prod["subtotal"] = number_format($prod["crrprc"] * $prod["crrctd"], 2);
            $total += $prod["crrprc"] * $prod["crrctd"];
            $prod["crrprc"] = number_format($prod["crrprc"], 2);
            $finalCarretilla[] = $prod;
            $counter++;
        }

        $viewData["carretilla"] = $finalCarretilla;
        $viewData["total"] = number_format($total, 2);

        // el botón solo dirige al checkout si hay productos
        $viewData["botonTexto"] = ($total > 0) ? "Ir al Checkout" : "Seguir comprando";
        $viewData["botonUrl"] = ($total > 0) ? "index.php?page=Checkout_Checkout" : "index.php?page=Index";
        $viewData["botonIcono"] = ($total > 0) ? "shopping-cart" : "store";

        \Views\Renderer::render("carretilla/carretilla", $viewData);
    }
}