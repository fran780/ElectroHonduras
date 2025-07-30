INSERT INTO `electronics_products` (`productId`, `productName`, `productDescription`, `productPrice`, `productImgUrl`, `productStock`, `productStatus`) VALUES
(1, 'Laptop HP Pavilion 15', 'Laptop con procesador Intel Core i5, 8GB RAM, 512GB SSD y pantalla Full HD de 15.6\".', 630.00, 'public/imagenes/HpPavilion.png', 9, 'ACT'),
(2, 'Samsung Galaxy S24', 'Teléfono inteligente con pantalla AMOLED de 6.8\", 256GB de almacenamiento y cámara de 200MP.', 799.99, 'public/imagenes/S24Ultra.png', 14, 'ACT'),
(3, 'Smart TV LG 55\"', 'Televisor inteligente 4K UHD con WebOS, compatible con Alexa y Google Assistant.', 329.99, 'public/imagenes/LG_SmartTV.png', 8, 'ACT'),
(4, 'Audífonos Sony WH-1000XM5', 'Audífonos inalámbricos con cancelación activa de ruido y batería de hasta 30 horas.', 259.00, 'public/imagenes/Sony_WH1000XM5.png', 20, 'ACT'),
(5, 'Cámara Canon EOS Rebel T7', 'Cámara réflex digital con sensor de 24.1 MP y lente 18-55mm incluida.', 649.99, 'public/imagenes/Camara.png', 5, 'ACT'),
(6, 'Consola PlayStation 5', 'Consola de videojuegos de última generación con SSD ultra rápido y control DualSense.', 499.99, 'public/imagenes/PS5.jpg', 7, 'ACT'),
(7, 'Reloj Apple Watch Series 9', 'Reloj inteligente con pantalla Always-On, seguimiento de salud y GPS integrado.', 399.00, 'public/imagenes/AppleWatch.png', 12, 'ACT'),
(8, 'Tablet Xiaomi Pad 6', 'Tablet con pantalla de 11\", procesador Snapdragon 870, 128GB de almacenamiento y batería de larga duración.', 299.00, 'public/imagenes/Xiaomi_Pad.png', 9, 'ACT'),
(9, 'Proyector Epson PowerLite X49', 'Proyector XGA con 3600 lúmenes, ideal para presentaciones y clases.', 498.00, 'public/imagenes/Proyector.png', 6, 'ACT'),
(10, 'Bocina JBL Charge 5', 'Altavoz portátil Bluetooth con sonido potente, batería de 20 horas y resistencia al agua.', 179.95, 'public/imagenes/JBL.png', 0, 'ACT');


INSERT INTO `roles` (`rolescod`, `rolesdsc`, `rolesest`) VALUES
('ADMIN', 'Administrador', 'ACT'),
('CLI', 'Cliente', 'ACT'),
('ECI', 'Encargado de inventario', 'ACT');


INSERT INTO roles_usuarios (usercod, rolescod, roleuserest, roleuserfch, roleuserexp) VALUES
(1, 'ADMIN', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR)),
(2, 'CLI', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR)),
(3, 'ECI', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR)),
(4, 'CLI', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));


INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Productos\\ProductosForm', 'Formulario de Productos', 'ACT', 'CTR'),
('Controllers\\Productos\\ProductosList', 'Listado de Productos', 'ACT', 'CTR'),
('Menu_Productos', 'Menu_Inventario_Productos', 'ACT', 'MNU'),
('productos_DEL', 'Eliminar Productos', 'ACT', 'FNC'),
('productos_DSP', 'Detalle de Productos', 'ACT', 'FNC'),
('productos_INS', 'Agregar Productos', 'ACT', 'FNC'),
('productos_UPD', 'Editar Productos', 'ACT', 'FNC');

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Checkout\\Checkout', 'Acceso al Checkout para clientes', 'ACT', 'CTR');


INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('ADMIN', 'Controllers\\Productos\\ProductosForm', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ADMIN', 'Controllers\\Productos\\ProductosList', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ADMIN', 'Menu_Productos', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ADMIN', 'productos_DEL', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ADMIN', 'productos_DSP', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ADMIN', 'productos_INS', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ADMIN', 'productos_UPD', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('CLI', 'Controllers\\Checkout\\Checkout', 'ACT', DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ECI', 'Controllers\\Productos\\ProductosForm', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ECI', 'Controllers\\Productos\\ProductosList', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ECI', 'Menu_Productos', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ECI', 'productos_DSP', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('ECI', 'productos_UPD', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Controllers\\Checkout\\History', 'Listado Historial de Transacciones', 'ACT', 'CTR'),
('Controllers\\Checkout\\HistoryDetail', 'Formulario de Historial de Transacciones', 'ACT', 'CTR');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES
('CLI', 'Controllers\\Checkout\\HistoryDetail', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR)),
('CLI', 'Controllers\\Checkout\\History', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR));

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
('Menu_TransHist', 'Menu_Transacciones', 'ACT', 'MNU');

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES
('CLI', 'Menu_TransHist', 'ACT',  DATE_ADD(NOW(), INTERVAL 1 YEAR));