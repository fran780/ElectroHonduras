<?php

namespace Dao\Usuarios;

use Dao\Table;
use Utilities\Validators;

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

        $sqlstr = "SELECT
                        u.usercod,
                       u.username,
                        u.useremail,
                       u.userest,
                        CASE WHEN u.userest = 'ACT' THEN 'Activo' ELSE 'Inactivo' END as userestDsc,
                        COALESCE(GROUP_CONCAT(DISTINCT r.rolesdsc ORDER BY r.rolesdsc SEPARATOR ', '), 'Sin roles') as rolesList
                    FROM usuario u
                    LEFT JOIN roles_usuarios ru
                        ON ru.usercod = u.usercod AND ru.roleuserest = 'ACT'
                    LEFT JOIN roles r
                        ON r.rolescod = ru.rolescod AND r.rolesest = 'ACT'";

        $sqlstrCount = "SELECT COUNT(*) as count FROM usuario u";

        $conditions = [];
        $params = [];

        if ($partialName != "") {
            $conditions[] = "u.username LIKE :partialName";
            $params["partialName"] = "%" . $partialName . "%";
        }

        if ($partialEmail != "") {
            $conditions[] = "u.useremail LIKE :partialEmail";
            $params["partialEmail"] = "%" . $partialEmail . "%";
        }

        if (in_array($status, ["ACT", "INA"])) {
            $conditions[] = "u.userest = :status";
            $params["status"] = $status;
        }

        if (count($conditions) > 0) {
            $where = " WHERE " . implode(" AND ", $conditions);
            $sqlstr .= $where;
            $sqlstrCount .= $where;
        }

        $sqlstr .= " GROUP BY u.usercod, u.username, u.useremail, u.userest";

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

    public static function getUsuarioByEmail(string $useremail)
    {
        $sqlstr = "SELECT usercod, username, useremail, userest FROM usuario WHERE useremail = :useremail";
        $params = ["useremail" => $useremail];
        return self::obtenerUnRegistro($sqlstr, $params);
    }

  public static function insertUsuario(
        string $username,
        string $useremail,
        string $userest
    ) {
        $username = trim(preg_replace('/\s+/', ' ', $username));
        if (!Validators::IsValidHumanName($username)) {
            throw new \Exception("El nombre debe tener al menos 3 letras y solo puede incluir letras, espacios, guiones o apóstrofes.");
        }
        $existingUser = self::getUsuarioByEmail($useremail);
        if ($existingUser) {
            throw new \Exception("El correo ya se encuentra registrado");
        }
        $conn = self::getConn();
        $sqlstr = "INSERT INTO usuario (username, useremail, userest, userfching)
                    VALUES (:username, :useremail, :userest, NOW())";
        $params = [
            "username" => $username,
            "useremail" => $useremail,
            "userest" => $userest
        ];
        self::executeNonQuery($sqlstr, $params, $conn);
        return intval($conn->lastInsertId());
    }

    public static function updateUsuario(
        int $usercod,
        string $username,
        string $useremail,
        string $userest
    ) {
        $username = trim(preg_replace('/\s+/', ' ', $username));
        if (!Validators::IsValidHumanName($username)) {
            throw new \Exception("El nombre debe tener al menos 3 letras y solo puede incluir letras, espacios, guiones o apóstrofes.");
        }
        $existingUser = self::getUsuarioByEmail($useremail);
        if ($existingUser && intval($existingUser["usercod"]) !== $usercod) {
            throw new \Exception("El correo ya se encuentra registrado");
        }
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
        $conn = self::getConn();
        try {
            $conn->beginTransaction();

            $params = ["usercod" => $usercod];

            // Elimina las asignaciones de roles para que la restricción de clave externa no bloquee la eliminación
            self::executeNonQuery(
                "DELETE FROM roles_usuarios WHERE usercod = :usercod",
                $params,
                $conn
            );

            // Borra cualquier artículo que el usuario aún pueda tener en su carrito
            self::executeNonQuery(
                "DELETE FROM carretilla WHERE usercod = :usercod",
                $params,
                $conn
            );

            $result = self::executeNonQuery(
                "DELETE FROM usuario WHERE usercod = :usercod",
                $params,
                $conn
            );

            $conn->commit();
            return $result;
        } catch (\Throwable $th) {
            if ($conn->inTransaction()) {
                $conn->rollBack();
            }
            throw $th;
        }
    }

    public static function getActiveRoles(): array
    {
        $sqlstr = "SELECT rolescod, rolesdsc FROM roles WHERE rolesest = 'ACT' ORDER BY rolesdsc";
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function getActiveRoleCodesForUser(int $usercod): array
    {
        $sqlstr = "SELECT rolescod FROM roles_usuarios WHERE usercod = :usercod AND roleuserest = 'ACT' ORDER BY roleuserfch DESC";
        $rows = self::obtenerRegistros($sqlstr, ["usercod" => $usercod]);
        $roles = array_map(static function ($row) {
            return $row["rolescod"];
        }, $rows);
        if (count($roles) > 1) {
            $roles = array_slice($roles, 0, 1);
        }
        return $roles;
    }

    public static function syncUsuarioRoles(int $usercod, array $rolescods): void
    {
        $rolescods = array_values(array_filter(array_unique(array_map('strval', $rolescods))));
        if (count($rolescods) > 1) {
            $rolescods = array_slice($rolescods, 0, 1);
        }
        $conn = self::getConn();
        try {
            $conn->beginTransaction();
            self::executeNonQuery(
                "DELETE FROM roles_usuarios WHERE usercod = :usercod",
                ["usercod" => $usercod],
                $conn
            );

            if (count($rolescods) > 0) {
                $sqlInsert = "INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp)
                              VALUES (:usercod, :rolescod, 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR))";
                foreach ($rolescods as $rolescod) {
                    self::executeNonQuery(
                        $sqlInsert,
                        [
                            "usercod" => $usercod,
                            "rolescod" => $rolescod
                        ],
                        $conn
                    );
                }
            }

            $conn->commit();
        } catch (\Throwable $th) {
            if ($conn->inTransaction()) {
                $conn->rollBack();
            }
            throw $th;
        }
    }
}
