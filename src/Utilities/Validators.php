<?php

namespace Utilities;

class Validators {

    static public function IsEmpty($valor)
    {
        return preg_match("/^\s*$/", $valor) && true;
    }

    static public function IsValidEmail($valor)
    {
        return preg_match("/^([a-z0-9_\.-]+\@[\da-z\.-]+\.[a-z\.]{2,6})$/", $valor) && true;
    }

    static public function IsValidPassword($valor){
        return preg_match("/^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[^\w\d\s:])([^\s]){8,32}$/", $valor) && true;
    }

     static public function IsValidHonduranCelPhone($valor)
    {
        return preg_match("/^\+?\(?(504)?\)?\s?[389]\d{3}[\-\s]?\d{4}$/", $valor) && true;
    }

    private function __construct()
    {
        
    }
    private function __clone()
    {
        
    }
}

?>
