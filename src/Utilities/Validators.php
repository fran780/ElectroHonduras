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
     static public function IsValidHumanName($valor, $minLength = 3, $maxLength = 60)
    {
        if (self::IsEmpty($valor)) {
            return false;
        }

        $valor = trim($valor);
        $length = function_exists('mb_strlen') ? mb_strlen($valor, 'UTF-8') : strlen($valor);

        if ($length < $minLength || $length > $maxLength) {
            return false;
        }

        return preg_match("/^[\p{L}]+(?:[ \-'][\p{L}]+)*$/u", $valor) === 1;
    }


    private function __construct()
    {
        
    }
    private function __clone()
    {
        
    }
}