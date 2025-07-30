<?php

namespace Dao\Usuarios;

use Dao\Table;

class Usuarios extends Table
{
    public static function getUsuarios(
        string $partialName = "",
        string $partialEmail = "",
        string $status = "",
        string $orderBy = "",
        bool $orderDescending = false,
        int $page = 0,
        int $itemsPerPage = 10
    ) {
        $sqlstr = "SELECT usercod, username, useremail, userest,
                   CASE WHEN userest = 'ACT' THEN 'Activo' ELSE 'Inactivo' END as userestDsc
                   FROM usuario";

        $sqlstrCount = "SELECT COUNT(*) as count FROM usuario";

        $conditions = [];
        $params = [];

        if ($partialName != "") {
            $conditions[] = "username LIKE :partialName";
            $params["partialName"] = "%" . $partialName . "%";
        }

        if ($partialEmail != "") {
            $conditions[] = "useremail LIKE :partialEmail";
            $params["partialEmail"] = "%" . $partialEmail . "%";
        }

        if (in_array($status, ["ACT", "INA"])) {
            $conditions[] = "userest = :status";
            $params["status"] = $status;
        }

        if (count($conditions) > 0) {
            $where = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $where;
            $sqlstrCount .= $where;
        }

        if (!in_array($orderBy, ["usercod", "username", "useremail", ""])) {
            throw new \Exception("Invalid orderBy value");
        }

        if ($orderBy != "") {
            $sqlstr .= " ORDER BY " . $orderBy;
            if ($orderDescending) {
                $sqlstr .= " DESC";
            }
        }

        $total = self::obtenerUnRegistro($sqlstrCount, $params)["count"];
        $pagesCount = ceil($total / $itemsPerPage);
        if ($page > $pagesCount - 1) {
            $page = $pagesCount - 1;
        }
        if ($page < 0) {
            $page = 0;
        }
        $sqlstr .= " LIMIT " . ($page * $itemsPerPage) . ", " . $itemsPerPage;

        $usuarios = self::obtenerRegistros($sqlstr, $params);
        return ["usuarios" => $usuarios, "total" => $total, "page" => $page, "itemsPerPage" => $itemsPerPage];
    }

    public static function getUsuarioById(int $usercod)
    {
        $sqlstr = "SELECT usercod, username, useremail, userest
                   FROM usuario WHERE usercod = :usercod";
        $params = ["usercod" => $usercod];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertUsuario(
        string $username,
        string $useremail,
        string $userest
    ) {
        $sqlstr = "INSERT INTO usuario (username, useremail, userest, userfching)
                   VALUES (:username, :useremail, :userest, NOW())";
        $params = [
            "username" => $username,
            "useremail" => $useremail,
            "userest" => $userest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateUsuario(
        int $usercod,
        string $username,
        string $useremail,
        string $userest
    ) {
        $sqlstr = "UPDATE usuario SET username = :username, useremail = :useremail,
                   userest = :userest WHERE usercod = :usercod";
        $params = [
            "usercod" => $usercod,
            "username" => $username,
            "useremail" => $useremail,
            "userest" => $userest
        ];
        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteUsuario(int $usercod)
    {
        $sqlstr = "DELETE FROM usuario WHERE usercod = :usercod";
        $params = ["usercod" => $usercod];
        return self::executeNonQuery($sqlstr, $params);
    }
}
