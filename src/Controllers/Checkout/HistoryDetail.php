<?php

namespace Controllers\Checkout;

use Controllers\PrivateController;
use Views\Renderer;
use Dao\Transactions\Transactions;
use Dao\Productos\Productos;
use Utilities\Security;
use Utilities\Site;
use Utilities\Checkout\OrderItemHelper;

class HistoryDetail extends PrivateController
{
    private $viewData = [];
    private $mode = "DSP";
    private $modeDescriptions = [
        "DSP" => "Detalle de Transacción %s"
    ];
    private $readonly = "readonly";
    private $showCommitBtn = false;
    private $txn = [];

    public function run(): void
    {
        try {
            $this->getData();
            $this->setViewData();
            Renderer::render("paypal/history_detail", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Checkout_History",
                $ex->getMessage()
            );
        }
    }

    private function getData(): void
    {
        $this->mode = $_GET["mode"] ?? "DSP";
        $transactionId = intval($_GET["id"] ?? 0);

        if ($transactionId <= 0) {
            throw new \Exception("ID de transacción inválido");
        }

        $this->txn = Transactions::getById($transactionId);

        if (!$this->txn) {
            throw new \Exception("No se encontró la transacción");
        }

        if ($this->txn["usercod"] !== Security::getUserId()) {
            throw new \Exception("Transacción no autorizada para este usuario");
        }

        $fecha = new \DateTime($this->txn["transdate"]);
        $this->txn["transdate"] = $fecha->format("Y-m-d");

        $decodedOrder = json_decode($this->txn["orderjson"], true);
        if (!is_array($decodedOrder)) {
            $decodedOrder = [];
        }
        $this->txn["orderjson"] = $decodedOrder;
        $this->txn["json_pretty"] = json_encode($decodedOrder, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);

        $this->txn["items"] = $this->prepareItems($decodedOrder);
        $financials = $this->computeFinancials($decodedOrder, $this->txn["items"]);

        $this->txn = array_merge($this->txn, $financials);

        // ---- Formateador sin moneda ----
        $fmt = function (float $v): string {
            return number_format($v, 2);
        };

        // Bruto (suma de líneas)
        $grossSum = 0.0;
        foreach ($this->txn["items"] as $it) {
            $grossSum += (($it["unitAmount"] ?? 0.0) * ($it["quantity"] ?? 1));
        }

        // Comisión total a repartir (positiva para mostrar)
        $totalFee = abs((float)($this->txn["paypalFeeAmount"] ?? 0.0));

        // Reparto proporcional + corrección de redondeo en la última fila
        $accumFee = 0.0;
        $lastIdx = count($this->txn["items"]) - 1;
        foreach ($this->txn["items"] as $idx => &$it) {
            $lineGross = (($it["unitAmount"] ?? 0.0) * ($it["quantity"] ?? 1));

            $share = ($grossSum > 0) ? ($lineGross / $grossSum) : 0.0;
            $lineFee = round($totalFee * $share, 2);

            if ($idx === $lastIdx) {
                $lineFee = round($totalFee - $accumFee, 2);
            }
            $accumFee += $lineFee;

            $lineNet = max(0.0, $lineGross - $lineFee);

            $it["lineGross"] = $lineGross;
            $it["lineFee"]   = $lineFee;
            $it["lineNet"]   = $lineNet;

            $it["lineGrossDisplay"] = $fmt($lineGross);
            $it["lineFeeDisplay"]   = $fmt($lineFee);
            $it["lineNetDisplay"]   = $fmt($lineNet);
        }
        unset($it);

        // Exponer los totales de la transacción dentro de cada item (para la vista)
        if (!empty($this->txn["items"]) && is_array($this->txn["items"])) {
            foreach ($this->txn["items"] as &$it) {
                $it["txnTotalDisplay"]     = $this->txn["totalDisplay"];     // Neto
                $it["txnPaypalFeeDisplay"] = ltrim($this->txn["paypalFeeDisplay"], '-'); // positivo visual
                $it["txnSubtotalDisplay"]  = $this->txn["subtotalDisplay"];  // Bruto
            }
            unset($it);
        }

        // ---- Totales generales ----
        $totalNet = 0.0;
        $totalFee = 0.0;
        $totalGross = 0.0;

        foreach ($this->txn["items"] as $it) {
            $totalNet   += $it["lineNet"] ?? 0.0;
            $totalFee   += $it["lineFee"] ?? 0.0;
            $totalGross += $it["lineGross"] ?? 0.0;
        }

        $this->txn["totals"] = [
            "netDisplay"   => $fmt($totalNet),
            "feeDisplay"   => $fmt($totalFee),
            "grossDisplay" => $fmt($totalGross)
        ];
    }

    private function setViewData(): void
    {
        $this->viewData["FormTitle"] = sprintf(
            $this->modeDescriptions[$this->mode],
            $this->txn["orderid"]
        );
        $this->viewData["readonly"] = $this->readonly;
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;
        $this->viewData["txn"] = $this->txn;
    }

    private function prepareItems(array $orderJson): array
    {
        $items = OrderItemHelper::extractItems($orderJson);
        if (count($items) === 0) {
            return [];
        }

        $productIds = [];
        foreach ($items as $item) {
            if ($item["productId"] !== null) {
                $productIds[$item["productId"]] = true;
            }
        }

        $productsMap = [];
        if (count($productIds) > 0) {
            $products = Productos::getByIds(array_keys($productIds));
            foreach ($products as $product) {
                $productsMap[intval($product["productId"])] = $product;
            }
        }

        foreach ($items as &$item) {
            $productId = $item["productId"];
            $productName = $item["name"];
            if ($productId !== null && isset($productsMap[$productId])) {
                $productName = $productsMap[$productId]["productName"];
            }
            $item["productName"] = $productName;
            $unitAmount = $item["unitAmount"] ?? 0.0;
            $item["unitAmountFormatted"] = number_format($unitAmount, 2);
            $item["lineTotalFormatted"] = number_format($unitAmount * ($item["quantity"] ?? 1), 2);
        }

        return $items;
    }

    private function computeFinancials(array $orderJson, array $items): array
    {
        $captures = $orderJson["purchase_units"][0]["payments"]["captures"][0] ?? [];

        $subtotal = isset($captures["amount"]["value"]) ? floatval($captures["amount"]["value"]) : 0.0;
        $currency = $captures["amount"]["currency_code"] ?? ($orderJson["purchase_units"][0]["amount"]["currency_code"] ?? ($this->txn["currency"] ?? ""));

        if ($subtotal === 0.0 && count($items) > 0) {
            foreach ($items as $item) {
                $subtotal += ($item["unitAmount"] ?? 0.0) * ($item["quantity"] ?? 1);
            }
        }

        $paypalFee = 0.0;
        $netAmount = $subtotal;

        if (isset($captures["seller_receivable_breakdown"])) {
            $breakdown = $captures["seller_receivable_breakdown"];
            if (isset($breakdown["paypal_fee"]["value"])) {
                $paypalFee = floatval($breakdown["paypal_fee"]["value"]);
            }
            if (isset($breakdown["net_amount"]["value"])) {
                $netAmount = floatval($breakdown["net_amount"]["value"]);
            }
        }

        if ($netAmount === $subtotal && $paypalFee > 0.0) {
            $netAmount = max(0.0, $subtotal - $paypalFee);
        }

        // ---- Formateador sin moneda ----
        $formatAmount = function (float $value): string {
            return number_format($value, 2);
        };

        $paypalFeeDisplay = $paypalFee > 0.0 ? sprintf("-%s", $formatAmount($paypalFee)) : $formatAmount($paypalFee);

        return [
            "subtotalAmount" => $subtotal,
            "paypalFeeAmount" => $paypalFee,
            "totalAmount" => $netAmount,
            "subtotalDisplay" => $formatAmount($subtotal),
            "paypalFeeDisplay" => $paypalFeeDisplay,
            "totalDisplay" => $formatAmount($netAmount),
            "currency" => $currency !== "" ? $currency : ($this->txn["currency"] ?? "")
        ];
    }
}
