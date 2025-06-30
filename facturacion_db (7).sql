-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-06-2025 a las 01:26:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `facturacion_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `estado`, `fecha_registro`) VALUES
(1, 'Aceites y Grasas', 1, '2025-06-09 02:41:13'),
(2, 'Aguas y Bebidas', 1, '2025-06-09 02:51:01'),
(3, 'Alimentos en Conserva', 1, '2025-06-12 21:15:05'),
(4, 'Bebidas Alcoholicas', 1, '2025-06-12 21:15:05'),
(5, 'Bebidas Carbonatadas', 1, '2025-06-12 21:15:05'),
(6, 'Bebidas Energeticas y Deportivas', 1, '2025-06-12 21:15:05'),
(7, 'Cereales y Barras', 1, '2025-06-12 21:15:05'),
(8, 'Chicles y Caramelos', 1, '2025-06-12 21:15:05'),
(9, 'Dulces y Golosinas', 1, '2025-06-12 21:15:05'),
(10, 'Lacteos y Derivados', 1, '2025-06-12 21:15:05'),
(11, 'Panaderia y Reposteria', 1, '2025-06-12 21:15:05'),
(12, 'Productos de Confiteria', 1, '2025-06-12 21:15:05'),
(13, 'Productos de temporada', 1, '2025-06-12 21:15:05'),
(14, 'Productos para Cumpleaños', 1, '2025-06-12 21:15:05'),
(15, 'Productos para Decoración', 1, '2025-06-12 21:15:05'),
(16, 'Productos para Fiestas', 1, '2025-06-12 21:15:05'),
(17, 'Productos para Picnic', 1, '2025-06-12 21:15:05'),
(18, 'Snacks y Botanas', 1, '2025-06-12 21:15:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `documento_numero` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `documento_tipo` enum('DNI','RUC') DEFAULT 'DNI',
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`documento_numero`, `nombre`, `documento_tipo`, `direccion`, `telefono`, `correo`, `estado`, `fecha_registro`) VALUES
('1045696812', 'Alex Salcedo', 'RUC', 'Av. La Molina', '953123445', 'alexsalce@hotmail.com', 1, '2025-05-31 20:10:50'),
('10568316987', 'Jose Chavez', 'RUC', 'Av. Miraflores', '906851765', 'jchavez2022@gmail.com', 1, '2025-06-12 05:12:46'),
('10693422656', 'Rodrigo Armando', 'RUC', 'Jr. El triunfo', '964831489', 'rgarmando@gmail.com', 1, '2025-06-12 05:20:25'),
('10986728', 'Roberto', 'DNI', 'Av. Jose Los Gavilanes', '908789156', 'roberto123@hotmail.com', 1, '2025-05-26 07:54:41'),
('20693215466', 'Joshua Almeda', 'RUC', 'Jr. La Union 368', '915632125', 'joshuaalma234@hotmail.com', 1, '2025-06-12 05:21:27'),
('20789435425', 'Martin Alves', 'RUC', 'Av. Los Girasoles 365', '984234165', 'martinalves2025@gmail.com', 1, '2025-06-12 05:31:09'),
('72946119', 'Jheremy Rosado', 'DNI', 'Av. Los tucanes', '987436125', 'jrosado2022@hotmail.com', 1, '2025-06-12 05:38:18'),
('76532165', 'Luca Romero', 'DNI', 'Av. Jose Carlos', '910235984', 'lucarome@gmail.com', 1, '2025-06-12 05:36:25'),
('78654235', 'Patrick Mendoza', 'DNI', 'Av. La Molina', '923698456', 'pmendozaluk@hotmail.com', 1, '2025-06-12 02:45:36'),
('79653216', 'Ruben Martinez', 'DNI', 'Jr. La Union 365', '910568369', 'rmartinez123@gmail.com', 0, '2025-06-12 04:29:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_factura`
--

CREATE TABLE `detalle_factura` (
  `id` int(11) NOT NULL,
  `factura_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_factura`
--

INSERT INTO `detalle_factura` (`id`, `factura_id`, `producto_id`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(4, 4, 3, 15, 2.60, 39.00),
(5, 4, 2, 12, 3.00, 36.00),
(6, 4, 1, 112, 3.50, 392.00),
(7, 5, 1, 6, 7.50, 45.00),
(8, 6, 2, 20, 7.00, 140.00),
(9, 7, 1, 22, 7.50, 165.00),
(10, 8, 5, 44, 18.00, 792.00),
(11, 8, 3, 22, 23.90, 525.80),
(12, 9, 1, 22, 7.50, 165.00),
(13, 9, 2, 22, 7.00, 154.00),
(14, 10, 1, 10, 7.50, 75.00),
(15, 10, 2, 11, 7.00, 77.00),
(16, 11, 1, 5, 7.50, 37.50),
(17, 11, 2, 6, 7.00, 42.00),
(18, 11, 3, 5, 23.90, 119.50),
(19, 11, 5, 3, 18.00, 54.00),
(20, 12, 1, 12, 7.50, 90.00),
(21, 13, 1, 33, 7.50, 247.50),
(22, 13, 2, 11, 7.00, 77.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_nota`
--

CREATE TABLE `detalle_nota` (
  `id` int(11) NOT NULL,
  `nota_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_nota`
--

INSERT INTO `detalle_nota` (`id`, `nota_id`, `producto_id`, `cantidad`, `precio_unitario`, `subtotal`) VALUES
(1, 2, 1, 3.00, 7.50, 22.50),
(2, 2, 2, 5.00, 7.00, 35.00),
(3, 2, 3, 3.00, 23.90, 71.70),
(4, 2, 5, 2.00, 18.00, 36.00),
(5, 3, 1, 4.00, 7.50, 30.00),
(6, 3, 2, 5.00, 7.00, 35.00),
(7, 3, 3, 4.00, 23.90, 95.60),
(8, 3, 5, 2.00, 18.00, 36.00),
(9, 4, 1, 4.00, 7.50, 30.00),
(10, 5, 3, 12.00, 2.60, 31.20),
(11, 5, 2, 11.00, 3.00, 33.00),
(12, 5, 1, 98.00, 3.50, 343.00),
(13, 6, 1, 5.00, 7.50, 37.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id` int(11) NOT NULL,
  `numero_factura` varchar(20) NOT NULL,
  `cliente_documento_numero` varchar(20) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `usuario_username` varchar(50) DEFAULT NULL,
  `fecha_emision` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `tipo_documento` enum('factura','boleta') NOT NULL DEFAULT 'factura',
  `estado` enum('activa','anulada') NOT NULL DEFAULT 'activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id`, `numero_factura`, `cliente_documento_numero`, `usuario_id`, `usuario_username`, `fecha_emision`, `total`, `tipo_documento`, `estado`) VALUES
(4, 'F00001', '1045696812', 1, 'admin', '2025-06-01 00:22:04', 467.00, 'factura', 'anulada'),
(5, 'F00002', '1045696812', 1, 'admin', '2025-06-10 17:37:23', 45.00, 'factura', 'activa'),
(6, 'F00003', '1045696812', 1, 'admin', '2025-06-10 23:30:03', 140.00, 'factura', 'anulada'),
(7, 'B00001', '1045696812', 1, 'admin', '2025-06-11 01:28:11', 165.00, 'boleta', 'activa'),
(8, 'F00004', '10986728', 1, 'admin', '2025-06-11 01:37:52', 1317.80, 'factura', 'activa'),
(9, 'F00005', '1045696812', 1, 'admin', '2025-06-11 05:28:37', 319.00, 'factura', 'activa'),
(10, 'F00006', '1045696812', 1, 'admin', '2025-06-11 05:49:50', 152.00, 'factura', 'activa'),
(11, 'F00007', '10986728', 1, 'admin', '2025-06-11 15:33:57', 253.00, 'factura', 'activa'),
(12, 'F00008', '79653216', 1, 'admin', '2025-06-12 19:14:26', 90.00, 'factura', 'activa'),
(13, 'F00009', '10986728', 1, 'admin', '2025-06-21 20:06:29', 324.50, 'factura', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas_credito_debito`
--

CREATE TABLE `notas_credito_debito` (
  `id` int(11) NOT NULL,
  `factura_id` int(11) NOT NULL,
  `tipo_nota` enum('credito','debito') NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `fecha_emision` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activo','anulado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas_credito_debito`
--

INSERT INTO `notas_credito_debito` (`id`, `factura_id`, `tipo_nota`, `motivo`, `monto`, `codigo`, `fecha_emision`, `estado`) VALUES
(2, 11, 'credito', 'Nuevas Cantidades de Productos Agregadas', 165.20, NULL, '2025-06-19 00:50:59', 'activo'),
(3, 11, 'credito', 'Productos para devolver', 196.60, NULL, '2025-06-21 14:29:46', 'activo'),
(4, 5, 'credito', 'Devolución', 30.00, NULL, '2025-06-21 14:41:55', 'activo'),
(5, 4, 'credito', 'Nueva Devolución', 407.20, NULL, '2025-06-21 14:43:45', 'activo'),
(6, 5, 'debito', 'PRUEBA 1', 37.50, NULL, '2025-06-21 14:46:45', 'activo'),
(8, 4, 'credito', 'DEVOLUCIÓN DE PRODUCTOS', 467.00, NULL, '2025-06-23 17:06:50', 'activo'),
(9, 4, 'credito', 'Devolución de Productos', 467.00, NULL, '2025-06-23 17:21:32', 'activo'),
(10, 6, 'credito', 'DEVOLUCIÓN DE PRODUCTOS', 140.00, NULL, '2025-06-23 17:32:25', 'activo'),
(11, 9, 'credito', 'DEVOLUCION', 319.00, 'NC-9-17507', '2025-06-23 18:24:47', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `proveedor_id` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `categoria_id` int(11) DEFAULT NULL,
  `unidad` enum('por paquetes (x6)','por decena (x12)') NOT NULL DEFAULT 'por paquetes (x6)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `stock`, `proveedor_id`, `estado`, `fecha_registro`, `categoria_id`, `unidad`) VALUES
(1, 'ACEITE BELTRAN', 'ACEITE BELTRAN', 7.50, 241, 2, 1, '2025-05-26 08:34:09', 1, 'por paquetes (x6)'),
(2, 'ACEITE MIRASOL', 'ACEITE MIRASOL', 7.00, 87, 1, 1, '2025-05-31 20:06:40', 1, 'por paquetes (x6)'),
(3, 'AGUA CIELO 20LT', 'AGUA CIELO 20LT', 23.90, 97, 2, 0, '2025-06-01 00:21:24', 2, 'por paquetes (x6)'),
(4, 'AGUA CIELO 2500LT X6UD', 'AGUA CIELO 2500LT X6UD', 18.20, 23, 1, 1, '2025-06-09 06:59:49', 2, 'por paquetes (x6)'),
(5, 'AGUA CIELO 625ML', 'AGUA CIELO 625ML X15UD', 18.00, 9, 2, 1, '2025-06-09 08:03:16', 2, 'por paquetes (x6)'),
(6, 'AGUA CIELO 7LT', 'AGUA CIELO 7LTX2', 6.90, 57, 6, 1, '2025-06-13 04:52:21', 2, 'por paquetes (x6)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `documento_numero` varchar(11) NOT NULL,
  `documento_tipo` enum('RUC') DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `estado` tinyint(4) DEFAULT 1,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `documento_numero`, `documento_tipo`, `nombre`, `direccion`, `telefono`, `correo`, `estado`, `fecha_registro`) VALUES
(1, '10729412848', 'RUC', 'Roberto Gonzales', 'Av. Jose Los Gavilanes123', '910234890', 'robertoonzag@hotmail.com', 1, '2025-05-26 08:10:34'),
(2, '10265983519', 'RUC', 'Alex Salcedo', 'Av. La Molina', '953123445', 'alexsalce@hotmail.com', 1, '2025-05-31 23:43:57'),
(6, '10543241782', 'RUC', 'Patrick Mendoza', 'Av. La Molina', '908907123', 'pmendozaluk@hotmail.com', 1, '2025-06-12 03:04:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('admin','vendedor') DEFAULT 'vendedor',
  `estado` tinyint(4) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `correo`, `password`, `rol`, `estado`, `fecha_creacion`) VALUES
(1, 'asalcedo', 'alex_@gmail.com', 'scrypt:32768:8:1$LL8PcaHsBVjtuKeS$353a680ac3823feee8c44f9e5522931163debb14819bf75356558912c254915d8e90f0fb9a79f5f3433f5d634fb0c5215077c4328e6008c6fdd9e1515bdc4179', 'admin', 1, '2025-05-05 22:54:57'),
(3, 'Roberto', 'roberto123@hotmail.com', 'scrypt:32768:8:1$ubOh2q5ZXDYYd6dL$0a1f6dbed1a7a6fe3c694eb3306984aa008a7d3061c2f87706db9ec5b708da3a87247bafb81f43a7e8dcb4b860d064e40140430722d513b74f6745ae787b5ba5', 'vendedor', 1, '2025-05-26 05:46:19');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`documento_numero`);

--
-- Indices de la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `factura_id` (`factura_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `detalle_nota`
--
ALTER TABLE `detalle_nota`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nota_id` (`nota_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_documento_numero` (`cliente_documento_numero`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `notas_credito_debito`
--
ALTER TABLE `notas_credito_debito`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `factura_id` (`factura_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_id` (`proveedor_id`),
  ADD KEY `fk_categoria_id` (`categoria_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `detalle_nota`
--
ALTER TABLE `detalle_nota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `notas_credito_debito`
--
ALTER TABLE `notas_credito_debito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_factura`
--
ALTER TABLE `detalle_factura`
  ADD CONSTRAINT `detalle_factura_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`id`),
  ADD CONSTRAINT `detalle_factura_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `detalle_nota`
--
ALTER TABLE `detalle_nota`
  ADD CONSTRAINT `detalle_nota_ibfk_1` FOREIGN KEY (`nota_id`) REFERENCES `notas_credito_debito` (`id`),
  ADD CONSTRAINT `detalle_nota_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `facturas_ibfk_1` FOREIGN KEY (`cliente_documento_numero`) REFERENCES `clientes` (`documento_numero`),
  ADD CONSTRAINT `facturas_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `notas_credito_debito`
--
ALTER TABLE `notas_credito_debito`
  ADD CONSTRAINT `notas_credito_debito_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_categoria_id` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
