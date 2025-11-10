<?php
 
 namespace Controllers\Checkout;
 
 use Controllers\PublicController;
 use Dao\Transactions\Transactions;
 use Dao\Cart\Cart;
 
 class Accept extends PublicController
 {
     public function run(): void
     {
         $dataview = [];
         $token = $_GET["token"] ?? "";
         $session_token = $_SESSION["orderid"] ?? "";
         $orderId = $token;
 
         $result = null;
 
        $localItems = [];
        $shouldPersistOrderFile = false;

         if ($token !== "" && $token === $session_token) {
             $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                 \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                 \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
             );
 
             $result = $PayPalRestApi->captureOrder($session_token);
 
             if ($result && isset($result->status) && $result->status === "COMPLETED") {
                 $orderId = $result->id ?? $session_token;
                $cartItems = Cart::getAuthCart(\Utilities\Security::getUserId());
                foreach ($cartItems as $cartItem) {
                    $localItems[] = [
                        "productId" => isset($cartItem["productId"]) ? intval($cartItem["productId"]) : null,
                        "sku" => isset($cartItem["productId"]) ? (string) $cartItem["productId"] : null,
                        "productName" => $cartItem["productName"] ?? "",
                        "quantity" => isset($cartItem["crrctd"]) ? intval($cartItem["crrctd"]) : 1,
                        "unitPrice" => isset($cartItem["crrprc"]) ? floatval($cartItem["crrprc"]) : 0.0
                    ];
                }
                 $orderFile = sprintf("orders/order_%s.json", $orderId);
                $shouldPersistOrderFile = true;
 
                Cart::finalizeCart(\Utilities\Security::getUserId());
                 \Utilities\Context::setContext("CART_ITEMS", 0);
                 unset($_SESSION["orderid"]);
             }
         }
 
         if (!$result && $token !== "") {
             $orderFile = sprintf("orders/order_%s.json", $token);
             if (file_exists($orderFile)) {
                 $result = json_decode(file_get_contents($orderFile));
             }
         }
 
         if (!$result || !isset($result->status) || $result->status !== "COMPLETED") {
             header("Location: index.php");
             exit;
         }
 
         $amount = "";
         $currency = "";
         $paypalFee = "";
         $netAmount = "";
         $formattedDate = "";
 
         if (isset($result->purchase_units[0]->payments->captures[0]->amount)) {
             $amount = $result->purchase_units[0]->payments->captures[0]->amount->value;
             $currency = $result->purchase_units[0]->payments->captures[0]->amount->currency_code;
         }
 
         if (isset($result->purchase_units[0]->payments->captures[0]->seller_receivable_breakdown)) {
             $breakdown = $result->purchase_units[0]->payments->captures[0]->seller_receivable_breakdown;
             $paypalFee = $breakdown->paypal_fee->value ?? "";
             $netAmount = $breakdown->net_amount->value ?? "";
         }
 
             $dt = new \DateTime($result->update_time ?? 'now');
             $dt->setTimezone(new \DateTimeZone("America/Tegucigalpa"));
             $meses = [
                 "January" => "enero", "February" => "febrero", "March" => "marzo",
                 "April" => "abril", "May" => "mayo", "June" => "junio",
                 "July" => "julio", "August" => "agosto", "September" => "septiembre",
                 "October" => "octubre", "November" => "noviembre", "December" => "diciembre"
             ];
         $mes = $meses[$dt->format("F")];
         $hora = str_replace(["AM", "PM"], ["a. m.", "p. m."], $dt->format("h:i A"));
         $formattedDate = $dt->format("d") . " de " . $mes . " de " . $dt->format("Y") . ", " . $hora;
 
         $dataview["order"] = [
             "id" => $result->id ?? "",
             "update_time" => $formattedDate,
             "payer_name" => (isset($result->payer->name)) ?
                 trim(($result->payer->name->given_name ?? "") . " " . ($result->payer->name->surname ?? "")) : "",
             "payer_email" => $result->payer->email_address ?? "",
             "amount" => $amount,
             "currency" => $currency,
             "paypal_fee" => $paypalFee,
             "net_amount" => $netAmount
         ];
 
        $orderPayload = json_decode(json_encode($result), true);
        if (!empty($localItems)) {
            $orderPayload["_local_items"] = $localItems;
        }
        $dataview["orderjson"] = json_encode($orderPayload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

        if (!empty($orderId ?? "") && isset($shouldPersistOrderFile) && $shouldPersistOrderFile) {
            $orderFile = sprintf("orders/order_%s.json", $orderId);
            @file_put_contents($orderFile, json_encode($orderPayload, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
        }

         Transactions::addTransaction(
             \Utilities\Security::getUserId(),
             $orderId,
             $result->status ?? "",
             floatval($amount),
             $currency,
            json_encode($orderPayload)
         );
 
         \Views\Renderer::render("paypal/accept", $dataview);
     }
 }