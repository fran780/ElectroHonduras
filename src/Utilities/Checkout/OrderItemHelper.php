<?php

namespace Utilities\Checkout;

class OrderItemHelper
{
    public static function extractItems($orderData): array
    {
        if (is_string($orderData)) {
            if ($orderData === "") {
                return [];
            }
            $decoded = json_decode($orderData, true);
        } elseif (is_array($orderData)) {
            $decoded = $orderData;
        } else {
            return [];
        }

        if (!is_array($decoded)) {
            return [];
        }

        $items = [];

        $candidates = [];
        if (isset($decoded["purchase_units"][0]["items"]) && is_array($decoded["purchase_units"][0]["items"])) {
            $candidates = $decoded["purchase_units"][0]["items"];
        } elseif (
            isset($decoded["purchase_units"][0]["payments"]["captures"][0]["items"]) &&
            is_array($decoded["purchase_units"][0]["payments"]["captures"][0]["items"])) {
            $candidates = $decoded["purchase_units"][0]["payments"]["captures"][0]["items"];
        }

        foreach ($candidates as $candidate) {
            $sku = $candidate["sku"] ?? null;
            $productId = null;
            if ($sku !== null && $sku !== "" && is_numeric($sku)) {
                $productId = intval($sku);
            }

            $quantity = isset($candidate["quantity"]) ? intval($candidate["quantity"]) : 1;
            $unitAmount = 0.0;
            if (isset($candidate["unit_amount"]["value"])) {
                $unitAmount = floatval($candidate["unit_amount"]["value"]);
            }

            $items[] = [
                "productId" => $productId,
                "sku" => $sku,
                "quantity" => $quantity,
                "unitAmount" => $unitAmount,
                "name" => $candidate["name"] ?? ""
            ];
        }

        $localItems = [];
        if (isset($decoded["_local_items"]) && is_array($decoded["_local_items"])) {
            foreach ($decoded["_local_items"] as $localItem) {
                $localProductId = null;
                if (isset($localItem["productId"]) && is_numeric($localItem["productId"])) {
                    $localProductId = intval($localItem["productId"]);
                }

                $localSku = $localItem["sku"] ?? null;
                if ($localSku === null && $localProductId !== null) {
                    $localSku = (string) $localProductId;
                }

                $localItems[] = [
                    "productId" => $localProductId,
                    "sku" => $localSku,
                    "quantity" => isset($localItem["quantity"]) ? intval($localItem["quantity"]) : 1,
                    "unitAmount" => isset($localItem["unitPrice"]) ? floatval($localItem["unitPrice"]) : (isset($localItem["unitAmount"]) ? floatval($localItem["unitAmount"]) : 0.0),
                    "name" => $localItem["productName"] ?? ($localItem["name"] ?? "")
                ];
            }
        }

        if (!empty($localItems)) {
            $mergedByKey = [];
            foreach ($items as $item) {
                $key = $item["productId"] ?? $item["sku"] ?? null;
                if ($key === null) {
                    $mergedByKey[] = $item;
                } else {
                    $mergedByKey[$key] = $item;
                }
            }

            foreach ($localItems as $localItem) {
                $key = $localItem["productId"] ?? $localItem["sku"] ?? null;
                if ($key === null) {
                    $mergedByKey[] = $localItem;
                    continue;
                }

                if (!isset($mergedByKey[$key])) {
                    $mergedByKey[$key] = $localItem;
                    continue;
                }

                $mergedItem = $mergedByKey[$key];
                foreach (["productId", "sku", "quantity", "unitAmount", "name"] as $field) {
                    if (isset($localItem[$field]) && $localItem[$field] !== null && $localItem[$field] !== "") {
                        $mergedItem[$field] = $localItem[$field];
                    }
                }
                $mergedByKey[$key] = $mergedItem;
            }

            $items = array_values($mergedByKey);
        }

        if (empty($items) && !empty($localItems)) {
            $items = $localItems;
        }

        return array_map(function ($item) {
            return [
                "productId" => $item["productId"] ?? null,
                "sku" => $item["sku"] ?? null,
                "quantity" => isset($item["quantity"]) ? intval($item["quantity"]) : 1,
                "unitAmount" => isset($item["unitAmount"]) ? floatval($item["unitAmount"]) : 0.0,
                "name" => $item["name"] ?? ""
            ];
        }, $items);
    }
}