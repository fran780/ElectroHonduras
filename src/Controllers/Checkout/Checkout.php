<?php

namespace Controllers\Checkout;

use Dao\Cart\Cart;
use Utilities\Security;
use Utilities\Site;
use Controllers\PrivateController;

class Checkout extends PrivateController
{
    public function run(): void
    {
        Site::addLink("public/css/products.css");

        $viewData = [];

        $carretilla = Cart::getAuthCart(Security::getUserId());

        if ($this->isPostBack()) {
            if (isset($_POST["cancelPurchase"])) {
                Cart::clearCart(Security::getUserId());
                \Utilities\Context::setContext("CART_ITEMS", 0);
                Site::redirectTo("index.php?page=Index");
                return;
            }

            if (!is_array($carretilla) || count($carretilla) === 0) {
                Site::redirectTo("index.php?page=Carretilla_Carretilla");
                return;
            }

            $totalProductos = 0;
            foreach ($carretilla as $producto) {
                if ($producto["crrctd"] > 0) {
                    $totalProductos += $producto["crrctd"];
                }
            }

            if ($totalProductos <= 0) {
                Site::redirectTo("index.php?page=Carretilla_Carretilla");
                return;
            }

            $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                "test" . (time() - 10000000),
                "http://localhost/negociosweb/ElectroHonduras/index.php?page=Checkout_Error",
                "http://localhost/negociosweb/ElectroHonduras/index.php?page=Checkout_Accept"
            );

            $viewData["carretilla"] = $carretilla;

            foreach ($viewData["carretilla"] as $producto) {
                $PayPalOrder->addItem(
                    $producto["productName"],
                    $producto["productDescription"],
                    $producto["productId"],
                    $producto["crrprc"],
                    0,
                    $producto["crrctd"],
                    "DIGITAL_GOODS"
                );
            }

            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $PayPalRestApi->getAccessToken();
            $response = $PayPalRestApi->createOrder($PayPalOrder);

            if (isset($response->id)) {
                $_SESSION["orderid"] = $response->id;

                foreach ($response->links as $link) {
                    if ($link->rel == "approve") {
                        Site::redirectTo($link->href);
                    }
                }
            } else {
                error_log("Error: respuesta inesperada de PayPal");
                error_log(print_r($response, true));
                Site::redirectTo("index.php?page=Checkout_Error");
            }
            die();
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

        \Views\Renderer::render("paypal/checkout", $viewData);
    }
}
