<?php 
namespace Utilities\Cart;

class CartFns {

    public static function getAuthTimeDelta()
    {
        return 21600;
    }

    public static function getUnAuthTimeDelta()
    {
        return 600 ;

    }
      public static function getAnnonCartCode()
    {
        if (isset($_SESSION["annonCartCode"])) {
            return $_SESSION["annonCartCode"];
        };
        $_SESSION["annonCartCode"] = substr(md5("cart202502" . time() . random_int(10000, 99999)), 0, 128);
        return $_SESSION["annonCartCode"];
    }
}