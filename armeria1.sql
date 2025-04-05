-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-03-2025 a las 20:11:15
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
-- Base de datos: `armeria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `armas`
--

CREATE TABLE `armas` (
  `ID` int(11) NOT NULL COMMENT 'Identificador unico del arma',
  `tipo` varchar(20) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `calibre` varchar(20) NOT NULL,
  `descripcion` text NOT NULL,
  `stock_disponible` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `armas`
--

INSERT INTO `armas` (`ID`, `tipo`, `modelo`, `calibre`, `descripcion`, `stock_disponible`) VALUES
(1, 'Subfusil', 'Mp5', '9mm', 'prueba', 5),
(2, 'Fusil', 'm4', '6mm', 'fusil de salto', 2),
(4, 'Francotirador', 'L11', '7MM', 'Disparos a mas de 800 metros efectvios', 2),
(5, 'Pistola', 'beretti', '9mm', 'Disparos en rafagas y automatico', 2),
(7, 'Escopeta', 'Italy', '5MM', 'postas que explotan al impactar', 1),
(9, 'Escopeta', 'alemana', '11MM', 'Pruaba para clip', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `competiciones`
--

CREATE TABLE `competiciones` (
  `ID` int(11) NOT NULL COMMENT 'pk competiciones',
  `nombreCompeticion` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `nivel` varchar(20) NOT NULL COMMENT 'principiante-medio-avanzado',
  `descripcion` text NOT NULL COMMENT 'detalles o notas sobre la competicion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `competiciones`
--

INSERT INTO `competiciones` (`ID`, `nombreCompeticion`, `fecha`, `hora`, `nivel`, `descripcion`) VALUES
(1, 'Tiro al Blanco', '2025-02-26', '14:44:00', 'Intermedio', 'hola prueba 2'),
(2, 'Tiro al pc', '2025-02-28', '16:06:00', 'Intermedio', 'pegar tiros al pc'),
(3, 'Tiro al Plato', '2025-03-04', '16:05:00', 'Avanzado', 'Solo uso de escopetas'),
(4, 'trio con escopetas', '2025-03-02', '08:21:00', 'Intermedio', 'diparos a patos cambios para pruebas'),
(5, 'Tiro a alemania', '2025-03-01', '01:43:00', 'Avanzado', 'Quien de en el blanco gana 1 millon'),
(6, 'Tiro a la Paloma', '2025-03-02', '17:46:00', 'Avanzado', 'disparos a las gallinas, cambio realizado'),
(7, 'Tiro al coche', '2025-03-02', '22:20:00', 'Avanzado', 'Reventar ruedas a vehiculos cambios'),
(8, 'Tiros de prueba clip', '2025-03-02', '22:01:00', 'Avanzado', 'Prueba video'),
(9, 'Tiro al coche', '2025-03-02', '22:20:00', 'Avanzado', 'Reventar ruedas a vehiculos cambios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `ID` int(11) NOT NULL COMMENT 'identificador unico de la reserva',
  `id_usuario` int(11) NOT NULL,
  `id_arma` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`ID`, `id_usuario`, `id_arma`, `fecha`, `hora`, `tipo`, `estado`) VALUES
(1, 2, 1, '2025-02-26', '14:51:00', 'Practica', 'En espera'),
(2, 3, 1, '2025-02-28', '13:31:00', 'Practica', 'En espera'),
(3, 3, 2, '2025-02-28', '13:40:00', 'Practica', 'En espera'),
(4, 3, 2, '2025-02-27', '14:48:00', 'Competicion', 'En espera'),
(5, 3, 2, '2025-02-27', '14:48:00', 'Competicion', 'En espera'),
(6, 3, 1, '2025-02-19', '15:04:00', 'Competicion', 'En espera'),
(7, 2, 2, '2025-02-28', '14:24:00', 'Competicion', 'En espera'),
(9, 4, 2, '2025-02-28', '16:12:00', 'Practica', 'En espera'),
(10, 7, 2, '2025-02-28', '01:21:00', 'Practica', 'En espera'),
(11, 8, 2, '2025-02-28', '23:39:00', 'Practica', ''),
(13, 10, 2, '2025-02-28', '23:58:00', 'Competicion', 'En espera'),
(14, 2, 5, '2025-03-01', '12:33:00', 'Practica', 'En espera'),
(15, 11, 1, '2025-03-02', '13:59:00', 'Practica', 'En espera'),
(16, 12, 5, '2025-03-01', '13:09:00', 'Practica', 'En espera'),
(17, 13, 5, '2025-03-02', '21:59:00', 'Practica', 'En espera'),
(18, 14, 7, '2025-03-02', '21:06:00', 'Practica', 'En espera');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultadoscompeticiones`
--

CREATE TABLE `resultadoscompeticiones` (
  `ID` int(11) NOT NULL COMMENT 'pk resultado competiciones',
  `id_usuario` int(11) NOT NULL COMMENT 'fk usuario que participo en la competicion',
  `id_competicion` int(11) NOT NULL COMMENT 'competicion en la que se participo',
  `posicion` int(11) NOT NULL,
  `puntuacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resultadoscompeticiones`
--

INSERT INTO `resultadoscompeticiones` (`ID`, `id_usuario`, `id_competicion`, `posicion`, `puntuacion`) VALUES
(3, 10, 4, 1, 10),
(4, 3, 5, 1, 22),
(5, 4, 2, 1, 55),
(6, 7, 5, 1, 90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `telefono` varchar(9) NOT NULL,
  `fecha_Nacimiento` date NOT NULL,
  `tipo_Usuario` varchar(20) NOT NULL COMMENT '"Cliente o Administrador"'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID`, `nombre`, `apellido`, `dni`, `correo`, `contraseña`, `telefono`, `fecha_Nacimiento`, `tipo_Usuario`) VALUES
(1, 'admin', 'last name', '12345678T', 'admin@gmail.com', 'Admin1', '12345678', '0000-00-00', 'Administrador'),
(2, 'prueba', 'last name', '12345678J', 'ahdhdfjdfj@gmail.com', 'Prueba1', '12345678', '0000-00-00', 'Cliente'),
(3, 'prueba2', 'last name', '12345678S', 'afsgdgd@gmail.com', 'Prueba2', '12345678', '0000-00-00', 'Cliente'),
(4, 'elisa', 'last name', '50353281H', 'elisa@gmail.com', 'Elisa1', '12345678', '0000-00-00', 'Cliente'),
(5, 'sixto', 'llerena', '50353282L', 'sixto@gmail.com', 'Sixto1', '12345678', '0000-00-00', 'Cliente'),
(7, 'hp', 'firts name', '87654321Q', 'hp@gmail.com', 'HP12345', '12345678', '2025-02-28', 'Cliente'),
(8, 'prueba3', 'last name', '12345078F', 'prueba3@gmail.com', 'Prueba3', '12345678', '2025-02-28', 'Cliente'),
(9, 'cambio', 'firts name', '10987645A', 'cambio@gmail.com', 'Cambio1', '12345678', '2025-02-28', 'Cliente'),
(10, 'ryzen', 'last name', '09876543T', 'ryzen@gmail.com', 'Ryzen1', '12345678', '2025-02-28', 'Cliente'),
(11, 'cliente', 'prueba', '09876543L', 'cliente@gmail.com', 'Cliente1', '12345678', '2025-03-01', 'Cliente'),
(12, 'nvidia', 'rtx', '75849309L', 'nvidia@gmail.com', 'Nvidia1', '12345678', '2025-03-01', 'Cliente'),
(13, 'clip', 'video', '09871234N', 'video@gmail.com', 'Clip1', '12345678', '2025-03-02', 'Cliente'),
(14, 'Video', 'prueba', '28759042X', 'clip@gmail.com', 'Video1234', '12345678', '2025-03-02', 'Cliente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `armas`
--
ALTER TABLE `armas`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `competiciones`
--
ALTER TABLE `competiciones`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `reservas_usuarios_ID_FK` (`id_usuario`),
  ADD KEY `reservas_armas_ID_FK` (`id_arma`);

--
-- Indices de la tabla `resultadoscompeticiones`
--
ALTER TABLE `resultadoscompeticiones`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_id_usuario` (`id_usuario`),
  ADD KEY `fk_id_competicion` (`id_competicion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `DNI` (`dni`),
  ADD UNIQUE KEY `CORREO` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `armas`
--
ALTER TABLE `armas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identificador unico del arma', AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `competiciones`
--
ALTER TABLE `competiciones`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk competiciones', AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'identificador unico de la reserva', AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `resultadoscompeticiones`
--
ALTER TABLE `resultadoscompeticiones`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'pk resultado competiciones', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_armas_ID_FK` FOREIGN KEY (`id_arma`) REFERENCES `armas` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservas_usuarios_ID_FK` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `resultadoscompeticiones`
--
ALTER TABLE `resultadoscompeticiones`
  ADD CONSTRAINT `fk_id_competicion` FOREIGN KEY (`id_competicion`) REFERENCES `competiciones` (`ID`),
  ADD CONSTRAINT `fk_id_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
