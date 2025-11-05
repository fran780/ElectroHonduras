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
(3, 'ECI', 'ACT', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR));

/*Credenciales de los usuarios del sistema*/
INSERT INTO `usuario` (`usercod`, `useremail`, `username`, `userpswd`, `userfching`, `userpswdest`, `userpswdexp`, `userest`, `useractcod`, `userpswdchg`, `usertipo`) VALUES
(1, 'guillermoortega29@gmail.com', 'Guillermo Ortega', '$2y$10$oALGvNDVi4pcHgqmlI/vNOq6Syus.eLX6McCsNStuvwYgjsxAGP6K', '2025-10-20 19:19:44', 'ACT', '2026-01-18 00:00:00', 'ACT', '383530522863ab55255542c0ff72060c656290a9e6788779bd4c6cf59e660f74', '2025-10-20 19:19:44', 'PBL'),
(2, 'fmfran7777@gmail.com', 'Francisco Fernandez', '$2y$10$UZfDtBdUoKdSclmoD746bOE.SqsHfGV/ZaKJHpXDV0kAhmrbxp8pm', '2025-10-20 19:21:25', 'ACT', '2026-01-18 00:00:00', 'ACT', '1a57d19b95e94f5e6adacd155b976f99735557daedb06a319744013af243719c', '2025-10-20 19:21:25', 'PBL'),
(3, 'alejandropalacios2821@gmail.com', 'Alejandro Palacios', '$2y$10$UggMne3h6Gf1rLP2tpFl1OI9gaQd6CumJ2oBokOwHL2MDzvBta3p.', '2025-10-20 19:21:45', 'ACT', '2026-01-18 00:00:00', 'ACT', 'dd422ebdcea5f2b88ac779b40ae5e3fb31853e3e1ecc09e8c01e2e39e8ac2af8', '2025-10-20 19:21:45', 'PBL');

INSERT INTO `funciones` (`fncod`, `fndsc`, `fnest`, `fntyp`) VALUES
('Controllers\\Checkout\\Checkout', 'Acceso al Checkout para clientes', 'ACT', 'CTR');

INSERT INTO `funciones_roles` (`rolescod`, `fncod`, `fnrolest`, `fnexp`) VALUES
('CLI', 'Controllers\\Checkout\\Checkout', 'ACT', '2026-11-04');

/*funciones para que cada usuarios acceda a sus modulos correspondientes*/

INSERT INTO funciones_roles (rolescod, fncod, fnrolest, fnexp) VALUES
('ADMIN', 'Controllers\\Productos\\ProductosForm', 'ACT', '2026-11-04'),
('ADMIN', 'Controllers\\Productos\\ProductosList', 'ACT', '2026-11-04'),
('ADMIN', 'Controllers\\Usuarios\\Usuario', 'ACT', '2026-11-04'),
('ADMIN', 'Controllers\\Usuarios\\Usuarios', 'ACT', '2026-11-04'),
('ADMIN', 'Menu_Productos', 'ACT', '2026-11-04'),
('ADMIN', 'Menu_Usuarios', 'ACT', '2026-11-04'),
('ADMIN', 'productos_DEL', 'ACT', '2026-11-04'),
('ADMIN', 'productos_DSP', 'ACT', '2026-11-04'),
('ADMIN', 'productos_INS', 'ACT', '2026-11-04'),
('ADMIN', 'productos_UPD', 'ACT', '2026-11-04'),
('ECI', 'Controllers\\Productos\\ProductosForm', 'ACT', '2026-11-04'),
('ECI', 'Controllers\\Productos\\ProductosList', 'ACT', '2026-11-04'),
('ECI', 'Menu_Productos', 'ACT', '2026-11-04'),
('ECI', 'productos_DSP', 'ACT', '2026-11-04'),
('ECI', 'productos_UPD', 'ACT', '2026-11-04');

INSERT INTO funciones (fncod, fndsc, fnest, fntyp) VALUES
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