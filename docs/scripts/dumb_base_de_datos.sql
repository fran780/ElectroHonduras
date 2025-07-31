-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-07-2025 a las 10:41:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectoeh`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `bitacoracod` int(11) NOT NULL,
  `bitacorafch` datetime DEFAULT NULL,
  `bitprograma` varchar(255) DEFAULT NULL,
  `bitdescripcion` varchar(255) DEFAULT NULL,
  `bitobservacion` mediumtext DEFAULT NULL,
  `bitTipo` char(3) DEFAULT NULL,
  `bitusuario` bigint(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carretilla`
--

CREATE TABLE `carretilla` (
  `usercod` bigint(10) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carretillaanon`
--

CREATE TABLE `carretillaanon` (
  `anoncod` varchar(128) NOT NULL,
  `productId` int(11) NOT NULL,
  `crrctd` int(5) NOT NULL,
  `crrprc` decimal(12,2) NOT NULL,
  `crrfching` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `electronics_products`
--

CREATE TABLE `electronics_products` (
  `productId` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productDescription` text NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productImgUrl` varchar(255) NOT NULL,
  `productStock` int(11) NOT NULL DEFAULT 0,
  `productStatus` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `electronics_products`
--

INSERT INTO `electronics_products` (`productId`, `productName`, `productDescription`, `productPrice`, `productImgUrl`, `productStock`, `productStatus`) VALUES
(1, 'Laptop HP Pavilion 15', 'Laptop con procesador Intel Core i5, 8GB RAM, 512GB SSD y pantalla Full HD de 15.6\".', 630.00, 'public/imagenes/HpPavilion.png', 8, 'ACT'),
(2, 'Samsung Galaxy S24', 'Teléfono inteligente con pantalla AMOLED de 6.8\", 256GB de almacenamiento y cámara de 200MP.', 799.99, 'public/imagenes/S24Ultra.png', 18, 'ACT'),
(3, 'Smart TV LG 55\"', 'Televisor inteligente 4K UHD con WebOS, compatible con Alexa y Google Assistant.', 329.99, 'public/imagenes/LG_SmartTV.png', 8, 'ACT'),
(4, 'Audífonos Sony WH-1000XM5', 'Audífonos inalámbricos con cancelación activa de ruido y batería de hasta 30 horas.', 259.00, 'public/imagenes/Sony_WH1000XM5.png', 19, 'ACT'),
(5, 'Cámara Canon EOS Rebel T7', 'Cámara réflex digital con sensor de 24.1 MP y lente 18-55mm incluida.', 649.99, 'public/imagenes/Camara.png', 5, 'ACT'),
(6, 'Consola PlayStation 5', 'Consola de videojuegos de última generación con SSD ultra rápido y control DualSense.', 499.99, 'public/imagenes/PS5.jpg', 7, 'ACT'),
(7, 'Reloj Apple Watch Series 9', 'Reloj inteligente con pantalla Always-On, seguimiento de salud y GPS integrado.', 399.00, 'public/imagenes/AppleWatch.png', 12, 'ACT'),
(8, 'Tablet Xiaomi Pad 6', 'Tablet con pantalla de 11\", procesador Snapdragon 870, 128GB de almacenamiento y batería de larga duración.', 299.00, 'public/imagenes/Xiaomi_Pad.png', 9, 'ACT'),
(9, 'Proyector Epson PowerLite X49', 'Proyector XGA con 3600 lúmenes, ideal para presentaciones y clases.', 498.00, 'public/imagenes/Proyector.png', 6, 'ACT'),
(10, 'Bocina JBL Charge 5', 'Altavoz portátil Bluetooth con sonido potente, batería de 20 horas y resistencia al agua.', 179.95, 'public/imagenes/JBL.png', 4, 'ACT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones`
--

CREATE TABLE `funciones` (
  `fncod` varchar(255) NOT NULL,
  `fndsc` varchar(255) DEFAULT NULL,
  `fnest` char(3) DEFAULT NULL,
  `fntyp` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `funciones`
--

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Checkout\\Checkout', 'Acceso al Checkout para clientes', 'ACT', 'CTR'),
('Controllers\\Checkout\\History', 'Listado Historial de Transacciones', 'ACT', 'CTR'),
('Controllers\\Checkout\\HistoryDetail', 'Formulario de Historial de Transacciones', 'ACT', 'CTR'),
('Controllers\\Productos\\ProductosForm', 'Formulario de Productos', 'ACT', 'CTR'),
('Controllers\\Productos\\ProductosList', 'Listado de Productos', 'ACT', 'CTR'),
('Controllers\\Usuarios\\Usuario', 'Formulario de Usuarios', 'ACT', 'CTR'),
('Controllers\\Usuarios\\Usuarios', 'Listado de Usuarios', 'ACT', 'CTR'),
('Menu_PaymentCheckout', 'Menu_PaymentCheckout', 'ACT', 'MNU'),
('Menu_Productos', 'Menu_Inventario_Productos', 'ACT', 'MNU'),
('Menu_TransHist', 'Menu_TransHist', 'ACT', 'MNU'),
('Menu_Usuarios', 'Menu_Usuarios', 'ACT', 'MNU'),
('productos_DEL', 'Eliminar Productos', 'ACT', 'FNC'),
('productos_DSP', 'Detalle de Productos', 'ACT', 'FNC'),
('productos_INS', 'Agregar Productos', 'ACT', 'FNC'),
('productos_UPD', 'Editar Productos', 'ACT', 'FNC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funciones_roles`
--

CREATE TABLE `funciones_roles` (
  `rolescod` varchar(128) NOT NULL,
  `fncod` varchar(255) NOT NULL,
  `fnrolest` char(3) DEFAULT NULL,
  `fnexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `funciones_roles`
--

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('ADMIN', 'Controllers\\Productos\\ProductosForm', 'ACT', '2026-07-29 08:56:06'),
('ADMIN', 'Controllers\\Productos\\ProductosList', 'ACT', '2026-07-29 08:56:06'),
('ADMIN', 'Controllers\\Usuarios\\Usuario', 'ACT', '2026-07-30 11:05:03'),
('ADMIN', 'Controllers\\Usuarios\\Usuarios', 'ACT', '2026-07-30 11:05:03'),
('ADMIN', 'Menu_Productos', 'ACT', '2026-07-29 08:56:06'),
('ADMIN', 'Menu_Usuarios', 'ACT', '2026-07-30 11:05:03'),
('ADMIN', 'productos_DEL', 'ACT', '2026-07-29 08:56:06'),
('ADMIN', 'productos_DSP', 'ACT', '2026-07-29 08:56:06'),
('ADMIN', 'productos_INS', 'ACT', '2026-07-29 08:56:06'),
('ADMIN', 'productos_UPD', 'ACT', '2026-07-29 08:56:06'),
('CLI', 'Controllers\\Checkout\\Checkout', 'ACT', '2026-07-29 16:54:21'),
('CLI', 'Controllers\\Checkout\\History', 'ACT', '2026-07-30 00:01:58'),
('CLI', 'Controllers\\Checkout\\HistoryDetail', 'ACT', '2026-07-30 00:01:58'),
('CLI', 'Menu_TransHist', 'ACT', '2026-07-30 00:02:04'),
('ECI', 'Controllers\\Productos\\ProductosForm', 'ACT', '2026-07-29 21:21:15'),
('ECI', 'Controllers\\Productos\\ProductosList', 'ACT', '2026-07-29 21:21:15'),
('ECI', 'Menu_Productos', 'ACT', '2026-07-29 21:21:15'),
('ECI', 'productos_DSP', 'ACT', '2026-07-29 21:21:15'),
('ECI', 'productos_UPD', 'ACT', '2026-07-29 21:21:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rolescod` varchar(128) NOT NULL,
  `rolesdsc` varchar(45) DEFAULT NULL,
  `rolesest` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('ADMIN', 'Administrador', 'ACT'),
('CLI', 'Cliente', 'ACT'),
('ECI', 'Encargado de inventario', 'ACT');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_usuarios`
--

CREATE TABLE `roles_usuarios` (
  `usercod` bigint(10) NOT NULL,
  `rolescod` varchar(128) NOT NULL,
  `roleuserest` char(3) DEFAULT NULL,
  `roleuserfch` datetime DEFAULT NULL,
  `roleuserexp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`usercod`, `rolescod`, `roleuserest`, `roleuserfch`, `roleuserexp`) VALUES
(1, 'ADMIN', 'ACT', '2025-07-29 09:00:06', '2026-07-29 09:00:06'),
(2, 'CLI', 'ACT', '2025-07-29 09:00:06', '2026-07-29 09:00:06'),
(3, 'ECI', 'ACT', '2025-07-29 09:00:06', '2026-07-29 09:00:06'),
(4, 'CLI', 'ACT', '2025-07-29 09:00:06', '2026-07-29 09:00:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transactions`
--

CREATE TABLE `transactions` (
  `transactionId` int(11) NOT NULL,
  `usercod` bigint(10) NOT NULL,
  `orderid` varchar(128) NOT NULL,
  `transdate` datetime NOT NULL,
  `transstatus` varchar(45) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(5) NOT NULL,
  `orderjson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`orderjson`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `transactions`
--

INSERT INTO `transactions` (`transactionId`, `usercod`, `orderid`, `transdate`, `transstatus`, `amount`, `currency`, `orderjson`) VALUES
(1, 2, '45645983V8238590K', '2025-07-29 16:56:27', 'COMPLETED', 259.00, 'USD', '{\"id\":\"45645983V8238590K\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"fmfran7777@gmail.com\",\"account_id\":\"3DL3YE6RNXKEE\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743829749\",\"shipping\":{\"name\":{\"full_name\":\"Francisco Fernandez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"8CC86371N4005651M\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"259.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"259.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"12.99\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"246.01\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8CC86371N4005651M\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8CC86371N4005651M\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/45645983V8238590K\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-29T22:56:27Z\",\"update_time\":\"2025-07-29T22:56:27Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"email_address\":\"fmfran7777@gmail.com\",\"payer_id\":\"3DL3YE6RNXKEE\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/45645983V8238590K\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(2, 2, '6VH808680S149783S', '2025-07-29 17:18:42', 'COMPLETED', 1036.00, 'USD', '{\"id\":\"6VH808680S149783S\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"fmfran7777@gmail.com\",\"account_id\":\"3DL3YE6RNXKEE\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743831088\",\"shipping\":{\"name\":{\"full_name\":\"Francisco Fernandez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"6KG32449XD2089445\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"1036.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"1036.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"51.06\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"984.94\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/6KG32449XD2089445\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/6KG32449XD2089445\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6VH808680S149783S\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-29T23:18:43Z\",\"update_time\":\"2025-07-29T23:18:43Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"email_address\":\"fmfran7777@gmail.com\",\"payer_id\":\"3DL3YE6RNXKEE\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6VH808680S149783S\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(3, 2, '1W914447BL910054D', '2025-07-29 18:10:44', 'COMPLETED', 799.99, 'USD', '{\"id\":\"1W914447BL910054D\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"fmfran7777@gmail.com\",\"account_id\":\"3DL3YE6RNXKEE\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743834218\",\"shipping\":{\"name\":{\"full_name\":\"Francisco Fernandez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"9RD141783E650391A\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"799.99\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"799.99\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"39.50\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"760.49\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/9RD141783E650391A\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/9RD141783E650391A\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/1W914447BL910054D\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-30T00:10:44Z\",\"update_time\":\"2025-07-30T00:10:44Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"email_address\":\"fmfran7777@gmail.com\",\"payer_id\":\"3DL3YE6RNXKEE\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/1W914447BL910054D\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(4, 2, '61F18766H3251081K', '2025-07-29 21:09:25', 'COMPLETED', 630.00, 'USD', '{\"id\":\"61F18766H3251081K\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"fmfran7777@gmail.com\",\"account_id\":\"3DL3YE6RNXKEE\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743844933\",\"shipping\":{\"name\":{\"full_name\":\"Francisco Fernandez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"3VE9076316982614X\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"630.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"630.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"31.17\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"598.83\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/3VE9076316982614X\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/3VE9076316982614X\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/61F18766H3251081K\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-30T03:09:26Z\",\"update_time\":\"2025-07-30T03:09:26Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"email_address\":\"fmfran7777@gmail.com\",\"payer_id\":\"3DL3YE6RNXKEE\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/61F18766H3251081K\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(5, 2, '43T844295A002505N', '2025-07-29 22:36:36', 'COMPLETED', 799.99, 'USD', '{\"id\":\"43T844295A002505N\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"alefermejia7@gmail.com\",\"account_id\":\"JHYYY7RSDD9MN\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Alejandra\",\"surname\":\"Fern\\u00e1ndez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743850141\",\"shipping\":{\"name\":{\"full_name\":\"Alejandra Fern\\u00e1ndez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"1AY65359CG729471T\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"799.99\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"799.99\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"39.50\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"760.49\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/1AY65359CG729471T\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/1AY65359CG729471T\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/43T844295A002505N\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-30T04:36:37Z\",\"update_time\":\"2025-07-30T04:36:37Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Alejandra\",\"surname\":\"Fern\\u00e1ndez\"},\"email_address\":\"alefermejia7@gmail.com\",\"payer_id\":\"JHYYY7RSDD9MN\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/43T844295A002505N\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(6, 2, '7UW38166066533731', '2025-07-30 00:43:26', 'COMPLETED', 259.00, 'USD', '{\"id\":\"7UW38166066533731\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"fmfran7777@gmail.com\",\"account_id\":\"3DL3YE6RNXKEE\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743857796\",\"shipping\":{\"name\":{\"full_name\":\"Francisco Fernandez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"8MK95769LT649453T\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"259.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"259.00\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"12.99\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"246.01\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8MK95769LT649453T\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/8MK95769LT649453T\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/7UW38166066533731\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-30T06:43:27Z\",\"update_time\":\"2025-07-30T06:43:27Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"email_address\":\"fmfran7777@gmail.com\",\"payer_id\":\"3DL3YE6RNXKEE\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/7UW38166066533731\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(7, 4, '6V453751Y30790220', '2025-07-30 17:55:04', 'COMPLETED', 799.99, 'USD', '{\"id\":\"6V453751Y30790220\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"alefermejia7@gmail.com\",\"account_id\":\"JHYYY7RSDD9MN\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Alejandra\",\"surname\":\"Fern\\u00e1ndez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743919672\",\"shipping\":{\"name\":{\"full_name\":\"Alejandra Fern\\u00e1ndez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"3XK16370VH020900M\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"799.99\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"799.99\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"39.50\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"760.49\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/3XK16370VH020900M\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/3XK16370VH020900M\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6V453751Y30790220\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-30T23:55:04Z\",\"update_time\":\"2025-07-30T23:55:04Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Alejandra\",\"surname\":\"Fern\\u00e1ndez\"},\"email_address\":\"alefermejia7@gmail.com\",\"payer_id\":\"JHYYY7RSDD9MN\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/6V453751Y30790220\",\"rel\":\"self\",\"method\":\"GET\"}]}'),
(8, 2, '61G08450S3209602U', '2025-07-31 00:22:45', 'COMPLETED', 1429.99, 'USD', '{\"id\":\"61G08450S3209602U\",\"status\":\"COMPLETED\",\"payment_source\":{\"paypal\":{\"email_address\":\"fmfran7777@gmail.com\",\"account_id\":\"3DL3YE6RNXKEE\",\"account_status\":\"VERIFIED\",\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"address\":{\"country_code\":\"HN\"}}},\"purchase_units\":[{\"reference_id\":\"test1743942927\",\"shipping\":{\"name\":{\"full_name\":\"Francisco Fernandez\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Tegucigalpa\",\"admin_area_1\":\"Tegucigalpa\",\"postal_code\":\"12345\",\"country_code\":\"HN\"}},\"payments\":{\"captures\":[{\"id\":\"95746751YD8563249\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"1429.99\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"seller_receivable_breakdown\":{\"gross_amount\":{\"currency_code\":\"USD\",\"value\":\"1429.99\"},\"paypal_fee\":{\"currency_code\":\"USD\",\"value\":\"70.37\"},\"net_amount\":{\"currency_code\":\"USD\",\"value\":\"1359.62\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/95746751YD8563249\",\"rel\":\"self\",\"method\":\"GET\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/payments\\/captures\\/95746751YD8563249\\/refund\",\"rel\":\"refund\",\"method\":\"POST\"},{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/61G08450S3209602U\",\"rel\":\"up\",\"method\":\"GET\"}],\"create_time\":\"2025-07-31T06:22:45Z\",\"update_time\":\"2025-07-31T06:22:45Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"Francisco\",\"surname\":\"Fernandez\"},\"email_address\":\"fmfran7777@gmail.com\",\"payer_id\":\"3DL3YE6RNXKEE\",\"address\":{\"country_code\":\"HN\"}},\"links\":[{\"href\":\"https:\\/\\/api.sandbox.paypal.com\\/v2\\/checkout\\/orders\\/61G08450S3209602U\",\"rel\":\"self\",\"method\":\"GET\"}]}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usercod` bigint(10) NOT NULL,
  `useremail` varchar(80) DEFAULT NULL,
  `username` varchar(80) DEFAULT NULL,
  `userpswd` varchar(128) DEFAULT NULL,
  `userfching` datetime DEFAULT NULL,
  `userpswdest` char(3) DEFAULT NULL,
  `userpswdexp` datetime DEFAULT NULL,
  `userest` char(3) DEFAULT NULL,
  `useractcod` varchar(128) DEFAULT NULL,
  `userpswdchg` varchar(128) DEFAULT NULL,
  `usertipo` char(3) DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`, `userpswdchg`, `usertipo`) VALUES
(1, 'guillermoortega29@gmail.com', 'Guillermo Ortega', '$2y$10$EqyPQB2tkK4lkI9NK69IeuIr/aHMdnCpUGqKFDmsrP/MtKwlfUTfC', '2025-07-29 08:57:33', 'ACT', '2025-10-27 00:00:00', 'ACT', '83b3e0610e1f06a46eea428710c570eb3b9387b91be89fbf62e825b8cd7f684f', '2025-07-29 08:57:33', 'PBL'),
(2, 'fmfran7777@gmail.com', 'Francisco Fernández', '$2y$10$U/IlXPqcwQxFrCjDEPILuu94xnLAT4mo2KNpfhQzi7TtXGFkyOUcm', '2025-07-29 08:57:55', 'ACT', '2025-10-27 00:00:00', 'ACT', 'ea023badef598fce4210650aac6136d71c185ca1d74be632974f7021361284b5', '2025-07-29 08:57:55', 'PBL'),
(3, 'alejandropalacios2821@gmail.com', 'Alejandro Palacios', '$2y$10$hZuuX4xFs7Q2fWMYt01xZuKrtbMCjSwbM2KtEoDLlLIz0Z2WpBgmq', '2025-07-29 08:58:20', 'ACT', '2025-10-27 00:00:00', 'ACT', '77c635d8bad8cb320d1dca59bea159c39d5078610bb0da2e48c8d83c99ee17fc', '2025-07-29 08:58:20', 'PBL'),
(4, 'alefermejia7@gmail.com', 'Alejandra Fernández', '$2y$10$f5faxYyhzNz80klcwP1nWeomdcFElS9c6U1LhmwIrmIvNROQV/W1G', '2025-07-29 08:58:49', 'ACT', '2025-10-27 00:00:00', 'ACT', 'cdca0936556b876356cd47435c9f32199592281a073ad1657f08b3f0259cdbd4', '2025-07-29 08:58:49', 'PBL');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`bitacoracod`);

--
-- Indices de la tabla `carretilla`
--
ALTER TABLE `carretilla`
  ADD PRIMARY KEY (`usercod`,`productId`),
  ADD KEY `productId_idx` (`productId`);

--
-- Indices de la tabla `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD PRIMARY KEY (`anoncod`,`productId`),
  ADD KEY `productId_idx` (`productId`);

--
-- Indices de la tabla `electronics_products`
--
ALTER TABLE `electronics_products`
  ADD PRIMARY KEY (`productId`);

--
-- Indices de la tabla `funciones`
--
ALTER TABLE `funciones`
  ADD PRIMARY KEY (`fncod`);

--
-- Indices de la tabla `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD PRIMARY KEY (`rolescod`,`fncod`),
  ADD KEY `rol_funcion_key_idx` (`fncod`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rolescod`);

--
-- Indices de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD PRIMARY KEY (`usercod`,`rolescod`),
  ADD KEY `rol_usuario_key_idx` (`rolescod`);

--
-- Indices de la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transactionId`),
  ADD KEY `fk_transactions_user_idx` (`usercod`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usercod`),
  ADD UNIQUE KEY `useremail_UNIQUE` (`useremail`),
  ADD KEY `usertipo` (`usertipo`,`useremail`,`usercod`,`userest`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `bitacoracod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `electronics_products`
--
ALTER TABLE `electronics_products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transactionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usercod` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carretilla`
--
ALTER TABLE `carretilla`
  ADD CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `electronics_products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `carretillaanon`
--
ALTER TABLE `carretillaanon`
  ADD CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `electronics_products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `funciones_roles`
--
ALTER TABLE `funciones_roles`
  ADD CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_user` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
