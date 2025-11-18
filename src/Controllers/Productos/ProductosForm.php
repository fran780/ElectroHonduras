<?php

namespace Controllers\Productos;

use Controllers\PrivateController;
use Dao\Productos\Productos as DaoProductos;
use Utilities\Site;
use Utilities\Validators;
use Views\Renderer;

class ProductosForm extends PrivateController
{
    private $mode = "DSP";
    private $producto = [
        "productId" => 0,
        "productName" => "",
        "productDescription" => "",
        "productPrice" => 0.00,
        "productImgUrl" => "",
        "productStock" => 0,
        "productStatus" => "ACT"
    ];
    private $producto_xss_token = "";
    private $readonly = "";
    private $showCommitBtn = true;
    private $viewData = [];
    private $modeDescriptions = [
        "DSP" => "Detalle de %s",
        "INS" => "Nuevo Producto",
        "UPD" => "Editar %s",
        "DEL" => "Eliminar %s"
    ];

    public function run(): void
    {
        try {
            $this->getData();
            if ($this->isPostBack()) {
                if ($this->validateData()) {
                    $this->handleAction();
                }
            }
            $this->prepareViewData();
            Renderer::render("productos/productos_form", $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg("index.php?page=Productos_ProductosList", $ex->getMessage());
        }
    }

    private function getData(): void
    {
        $this->mode = $_GET["mode"] ?? "NOF";
        if (!isset($this->modeDescriptions[$this->mode])) {
            throw new \Exception("Modo inválido", 1);
        }
          if (!$this->isFeatureAutorized("productos_" . $this->mode)) {
            throw new \Exception("No tiene permisos para realizar esta acción.", 1);
        }

        $this->readonly = $this->mode === "DEL" ? "readonly" : "";
        $this->showCommitBtn = $this->mode !== "DSP";

        if ($this->mode !== "INS") {
            $productId = intval($_GET["productId"] ?? 0);
            $productoDB = DaoProductos::getByPrimaryKey($productId);
            if (!$productoDB) {
                throw new \Exception("Producto no encontrado", 1);
            }
            $this->producto = $productoDB;
        }
    }

    private function validateData(): bool
    {
        if ($this->mode === "DEL") {
            $this->producto["productId"] = intval($_POST["productId"] ?? 0);
            return true;
        }

        $errors = [];
        $this->producto_xss_token = $_POST["producto_xss_token"] ?? "";
        if (
            empty($this->producto_xss_token) ||
            $this->producto_xss_token !== ($_SESSION["producto_xss_token"] ?? "")
        ) {
            throw new \Exception("Acceso no autorizado o token inválido", 1);
        }
        $this->producto["productId"] = intval($_POST["productId"] ?? 0);
        $this->producto["productName"] = trim($_POST["productName"] ?? "");
        $this->producto["productDescription"] = trim($_POST["productDescription"] ?? "");
        $this->producto["productPrice"] = floatval($_POST["productPrice"] ?? 0);
        $this->producto["productImgUrl"] = trim($_POST["productImgUrl"] ?? "");
        $this->producto["productStock"] = intval($_POST["productStock"] ?? 0);
        $this->producto["productStatus"] = trim($_POST["productStatus"] ?? "ACT");

        if (Validators::IsEmpty($this->producto["productName"])) {
            $errors["productName_error"] = "El nombre es requerido";
        }
        if (Validators::IsEmpty($this->producto["productDescription"])) {
            $errors["productDescription_error"] = "La descripción es requerida";
        }
        
        if ($this->producto["productPrice"] <= 0) {
            $errors["productPrice_error"] = "El precio debe ser mayor a cero";
        }
        if ($this->producto["productStock"] < 0) {
            $errors["productStock_error"] = "El stock no puede ser negativo";
        }
         $existingProduct = DaoProductos::getByName($this->producto["productName"]);
        if ($existingProduct && intval($existingProduct["productId"]) !== $this->producto["productId"]) {
            $errors["productName_error"] = "Ya existe un producto con este nombre";
        }

        foreach ($errors as $key => $msg) {
            $this->producto[$key] = $msg;
        }

        return count($errors) === 0;
    }

    private function handleAction(): void
    {
        switch ($this->mode) {
            case "INS":
                $result = DaoProductos::add(
                    $this->producto["productName"],
                    $this->producto["productDescription"],
                    $this->producto["productPrice"],
                    $this->producto["productImgUrl"],
                    $this->producto["productStock"],
                    $this->producto["productStatus"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Productos_ProductosList", "Producto creado correctamente");
                }
                break;
            case "UPD":
                $result = DaoProductos::update(
                    $this->producto["productId"],
                    $this->producto["productName"],
                    $this->producto["productDescription"],
                    $this->producto["productPrice"],
                    $this->producto["productImgUrl"],
                    $this->producto["productStock"],
                    $this->producto["productStatus"]
                );
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Productos_ProductosList", "Producto actualizado correctamente");
                }
                break;
            case "DEL":
                $result = DaoProductos::delete($this->producto["productId"]);
                if ($result > 0) {
                    Site::redirectToWithMsg("index.php?page=Productos_ProductosList", "Producto eliminado correctamente");
                }
                break;
        }
    }

    private function prepareViewData(): void
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["FormTitle"] = sprintf($this->modeDescriptions[$this->mode], $this->producto["productName"] ?? "");
        $this->viewData["producto_xss_token"] = md5(uniqid(rand(), true));
        $_SESSION["producto_xss_token"] = $this->viewData["producto_xss_token"];
        $this->viewData["readonly"] = $this->readonly;
        $this->viewData["showCommitBtn"] = $this->showCommitBtn;

        $statusKey = "productStatus_" . strtolower($this->producto["productStatus"]);
        $this->producto[$statusKey] = "selected";

        $this->viewData["producto"] = $this->producto;
    }
}