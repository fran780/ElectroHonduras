<?php

namespace Dao\Productos;

use Dao\Table;

class Productos extends Table
{
    public static function getAll()
    {
        return self::obtenerRegistros("SELECT * FROM electronics_products", []);
    }

    public static function getByPrimaryKey($productId)
    {
        return self::obtenerUnRegistro(
            "SELECT * FROM electronics_products WHERE productId = :productId;",
            ["productId" => $productId]
        );
    }

    public static function getByName(string $productName)
    {
        return self::obtenerUnRegistro(
            "SELECT * FROM electronics_products WHERE productName = :productName;",
            ["productName" => $productName]
        );
    }

    public static function add($productName = null, $productDescription = null, $productPrice = null, $productImgUrl = null, $productStock = null, $productStatus = null)
    {
        $existingProduct = self::getByName($productName);
        if ($existingProduct) {
            throw new \Exception("Ya existe un producto con este nombre");
        }
        return self::executeNonQuery(
            "INSERT INTO electronics_products ( productName, productDescription, productPrice, productImgUrl, productStock, productStatus) VALUES (:productName, :productDescription, :productPrice, :productImgUrl, :productStock, :productStatus);",
            ["productName" => $productName, "productDescription" => $productDescription, "productPrice" => $productPrice, "productImgUrl" => $productImgUrl, "productStock" => $productStock, "productStatus" => $productStatus]
        );
    }

    public static function update($productId = null, $productName = null, $productDescription = null, $productPrice = null, $productImgUrl = null, $productStock = null, $productStatus = null)
    {
        $existingProduct = self::getByName($productName);
        if ($existingProduct && intval($existingProduct["productId"]) !== intval($productId)) {
            throw new \Exception("Ya existe un producto con este nombre");
        }
        return self::executeNonQuery(
            "UPDATE electronics_products SET productName = :productName, productDescription = :productDescription, productPrice = :productPrice, productImgUrl = :productImgUrl, productStock = :productStock, productStatus = :productStatus WHERE productId = :productId;",
            ["productId" => $productId, "productName" => $productName, "productDescription" => $productDescription, "productPrice" => $productPrice, "productImgUrl" => $productImgUrl, "productStock" => $productStock, "productStatus" => $productStatus]
        );
    }

    public static function delete($productId = null)
    {
        return self::executeNonQuery(
            "DELETE FROM electronics_products WHERE productId = :productId;",
            ["productId" => $productId]
        );
    }

    public static function getByIds(array $productIds): array
    {
        if (count($productIds) === 0) {
            return [];
        }

        $placeholders = [];
        $params = [];
        foreach (array_values($productIds) as $index => $productId) {
            $key = "productId" . $index;
            $placeholders[] = ":" . $key;
            $params[$key] = $productId;
        }

        $sql = sprintf(
            "SELECT productId, productName FROM electronics_products WHERE productId IN (%s);",
            implode(", ", $placeholders)
        );

        return self::obtenerRegistros($sql, $params);
    }

    public static function getProductos(
        string $partialName = "",
        string $status = "",
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT productId, productName, productDescription, productPrice,
                      productImgUrl, productStock, productStatus,
                      CASE WHEN productStatus = 'ACT' THEN 'Activo' ELSE 'Inactivo' END as productStatusDsc
               FROM electronics_products";
        $sqlstrCount = "SELECT COUNT(*) as total FROM electronics_products";

        $conditions = [];
        $params = [];

        if ($partialName !== "") {
            $conditions[] = "productName LIKE :partialName";
            $params["partialName"] = "%" . $partialName . "%";
        }

        if (in_array($status, ["ACT", "INA"])) {
            $conditions[] = "productStatus = :status";
            $params["status"] = $status;
        }

        if (count($conditions) > 0) {
            $where = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $where;
            $sqlstrCount .= $where;
        }

        $total = self::obtenerUnRegistro($sqlstrCount, $params)["total"];
        $pagesCount = max(ceil($total / $itemsPerPage), 1);
        if ($page > $pagesCount - 1) {
            $page = $pagesCount - 1;
        }

        $sqlstr .= " LIMIT " . max(0, $page * $itemsPerPage) . ", " . $itemsPerPage;
        $productos = self::obtenerRegistros($sqlstr, $params);

        return [
            "productos" => $productos,
            "total" => $total,
            "page" => $page,
            "itemsPerPage" => $itemsPerPage
        ];
    }
}
