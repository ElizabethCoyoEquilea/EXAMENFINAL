-- SQL Server Script converted from MySQL
-- Original MySQL script generation time: 15-07-2013 18:24:51
-- Original MySQL server version: 5.5.20

-- Set the database context (replace 'hotel' with your actual database name if different)
-- USE [hotel];
-- GO

-- Drop tables if they exist to ensure a clean creation, in reverse dependency order if foreign keys were present.
-- For this script, no foreign keys are defined, so order doesn't strictly matter for dropping.
use hotel;
go
IF OBJECT_ID('usuario', 'U') IS NOT NULL DROP TABLE usuario;
IF OBJECT_ID('tipo_habi', 'U') IS NOT NULL DROP TABLE tipo_habi;
IF OBJECT_ID('ser_hab', 'U') IS NOT NULL DROP TABLE ser_hab;
IF OBJECT_ID('servicios', 'U') IS NOT NULL DROP TABLE servicios;
IF OBJECT_ID('reservacion', 'U') IS NOT NULL DROP TABLE reservacion;
IF OBJECT_ID('reserva', 'U') IS NOT NULL DROP TABLE reserva;
IF OBJECT_ID('personal', 'U') IS NOT NULL DROP TABLE personal;
IF OBJECT_ID('habitacion', 'U') IS NOT NULL DROP TABLE habitacion;
IF OBJECT_ID('clientes', 'U') IS NOT NULL DROP TABLE clientes;
IF OBJECT_ID('asignacion_hab', 'U') IS NOT NULL DROP TABLE asignacion_hab;
IF OBJECT_ID('acumulador', 'U') IS NOT NULL DROP TABLE acumulador;
GO

-- Estructura de tabla para la tabla `acumulador`
IF OBJECT_ID('acumulador', 'U') IS NULL
CREATE TABLE acumulador (
    id_cont INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_hab INT NOT NULL,
    id_cli INT NOT NULL
);
GO

-- Estructura de tabla para la tabla `asignacion_hab`
IF OBJECT_ID('asignacion_hab', 'U') IS NULL
CREATE TABLE asignacion_hab (
    id_asig INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_hab INT NOT NULL,
    id_cli INT NOT NULL,
    fecha_ent DATE NOT NULL,
    fecha_sal DATE NOT NULL,
    num_dias INT NOT NULL,
    costo_total INT NOT NULL,
    estado_asig_hab VARCHAR(20) NOT NULL,
    num_asig INT NOT NULL,
	id_user INT
);
GO

-- Volcado de datos para la tabla `asignacion_hab`
SET IDENTITY_INSERT asignacion_hab ON;
INSERT INTO asignacion_hab (id_asig, id_hab, id_cli, fecha_ent, fecha_sal, num_dias, costo_total, estado_asig_hab, num_asig) VALUES
(2, 1, 2, '2013-07-14', '2013-07-15', 1, 50, 'CANCELADO', 1);
SET IDENTITY_INSERT asignacion_hab OFF;
GO

-- Estructura de tabla para la tabla `clientes`
IF OBJECT_ID('clientes', 'U') IS NULL
CREATE TABLE clientes (
    id_cli INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ap_cli VARCHAR(200) NOT NULL,
    nom_cli VARCHAR(200) NOT NULL,
    tipo_docu VARCHAR(100) NOT NULL,
    nro_doc_cli VARCHAR(50) NOT NULL,
    celular_cli VARCHAR(20) NOT NULL,
    procedencia_cli VARCHAR(100) NOT NULL,
    fecha_nac_cli DATE NOT NULL,
    estado_cli VARCHAR(20) NOT NULL
);
GO

-- Volcado de datos para la tabla `clientes`
SET IDENTITY_INSERT clientes ON;
INSERT INTO clientes (id_cli, ap_cli, nom_cli, tipo_docu, nro_doc_cli, celular_cli, procedencia_cli, fecha_nac_cli, estado_cli) VALUES
(1, 'ROBERT', 'ARBEN', 'PASAPORTE', '65987456', '78761623', 'HOLANDA', '1983-07-19', 'NO'),
(2, 'SEBASTIAN', 'JHON', 'CI', '789654258', '12568948', 'MEXICO', '1965-04-12', 'NO'),
(3, 'SOLIZ', 'MARCA ANTONIO', 'PASAPORTE', '89562113', '89564512', 'MEXICO', '1960-10-15', 'NO');
SET IDENTITY_INSERT clientes OFF;
GO

-- Estructura de tabla para la tabla `habitacion`
IF OBJECT_ID('habitacion', 'U') IS NULL
CREATE TABLE habitacion (
    id_hab INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    num_habi VARCHAR(20) NOT NULL,
    piso VARCHAR(30) NOT NULL,
    costo VARCHAR(20) NOT NULL, -- Keeping as VARCHAR as per original, assuming it might store non-numeric values
    id_tipo INT NOT NULL,
    num_camas INT NOT NULL,
    estado_asig VARCHAR(20) NOT NULL
);
GO

-- Volcado de datos para la tabla `habitacion`
SET IDENTITY_INSERT habitacion ON;
INSERT INTO habitacion (id_hab, num_habi, piso, costo, id_tipo, num_camas, estado_asig) VALUES
(1, '10', '1re piso', '50', 1, 1, 'LIBRE'),
(2, '10', '3 piso', '60', 2, 2, 'LIBRE'),
(3, '12', '4to piso', '50', 1, 1, 'LIBRE');
SET IDENTITY_INSERT habitacion OFF;
GO

-- Estructura de tabla para la tabla `personal`
IF OBJECT_ID('personal', 'U') IS NULL
CREATE TABLE personal (
    id_per INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ci_per VARCHAR(9) NOT NULL,
    apellidos_per VARCHAR(100) NOT NULL,
    nombres_per VARCHAR(100) NOT NULL,
    celular_per VARCHAR(12) NOT NULL,
    direccion_per VARCHAR(70) NOT NULL,
    estado_per VARCHAR(15) NOT NULL,
    email_per VARCHAR(50) NOT NULL,
    est_user VARCHAR(5) NOT NULL
);
GO

-- Volcado de datos para la tabla `personal`
SET IDENTITY_INSERT personal ON;
INSERT INTO personal (id_per, ci_per, apellidos_per, nombres_per, celular_per, direccion_per, estado_per, email_per, est_user) VALUES
(6, '2356849', 'MENDEZ ROCA', 'ROGER', '76176338', 'ANCELMO TAPIA', 'ACTIVO', 'roger.mendez.r@gmail.com', 'SI');
SET IDENTITY_INSERT personal OFF;
GO

-- Estructura de tabla para la tabla `reserva`
IF OBJECT_ID('reserva', 'U') IS NULL
CREATE TABLE reserva (
    id_res INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_hab INT NOT NULL,
    id_cli INT NOT NULL,
    fecha_in INT NOT NULL, -- Kept as INT as per original MySQL script, though DATE might be more logical
    fecha_fin INT NOT NULL, -- Kept as INT as per original MySQL script, though DATE might be more logical
    estado_res INT NOT NULL
);
GO

-- Estructura de tabla para la tabla `reservacion`
IF OBJECT_ID('reservacion', 'U') IS NULL
CREATE TABLE reservacion (
    id_res INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_hab INT NOT NULL,
    id_cli INT NOT NULL,
    fecha_in DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado_res VARCHAR(20) NOT NULL
);
GO

-- Volcado de datos para la tabla `reservacion`
SET IDENTITY_INSERT reservacion ON;
INSERT INTO reservacion (id_res, id_hab, id_cli, fecha_in, fecha_fin, estado_res) VALUES
(29, 1, 1, '2013-07-14', '2013-07-14', 'POSITIVO');
SET IDENTITY_INSERT reservacion OFF;
GO

-- Estructura de tabla para la tabla `servicios`
IF OBJECT_ID('servicios', 'U') IS NULL
CREATE TABLE servicios (
    id_ser INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre_ser VARCHAR(100) NOT NULL,
    descripcion_ser VARCHAR(150) NOT NULL,
    costo_ser INT NOT NULL, -- Changed from FLOAT to INT based on float(10,0) and example data
    ent_ser INT NOT NULL,
    sal_ser INT NOT NULL,
    saldo_ser INT NOT NULL
);
GO

-- Volcado de datos para la tabla `servicios`
SET IDENTITY_INSERT servicios ON;
INSERT INTO servicios (id_ser, nombre_ser, descripcion_ser, costo_ser, ent_ser, sal_ser, saldo_ser) VALUES
(1, 'CERVECITA', 'LATA DE 450 C', 9, 24, 2, 22),
(2, 'DESAYUNO', 'DESAYUNO COMPLETO', 6, 20, 1, 19),
(3, 'SODA', 'COLA COLA MINI', 1, 48, 0, 48),
(4, 'SODA', 'FANTA MINI', 2, 48, 0, 48),
(5, 'SHAMPO', 'SEDAL SACHET', 4, 15, 0, 15),
(6, 'HAMBURGUESAS', 'SIMPLE DE CARNE', 6, 15, 0, 15);
SET IDENTITY_INSERT servicios OFF;
GO

-- Estructura de tabla para la tabla `ser_hab`
IF OBJECT_ID('ser_hab', 'U') IS NULL
CREATE TABLE ser_hab (
    id_ser_hab INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_hab INT NOT NULL,
    id_ser INT NOT NULL,
    cant_ser INT NOT NULL,
    costo_ser DECIMAL(10,0) NOT NULL,
    costo_total REAL NOT NULL, -- FLOAT in MySQL maps to REAL in SQL Server
    num_asig_ser INT NOT NULL,
    estado_ser VARCHAR(20) NOT NULL,
	id_user INT
);
GO

-- Volcado de datos para la tabla `ser_hab`
SET IDENTITY_INSERT ser_hab ON;
INSERT INTO ser_hab (id_ser_hab, id_hab, id_ser, cant_ser, costo_ser, costo_total, num_asig_ser, estado_ser) VALUES
(1, 1, 2, 1, 6, 6, 1, 'CANCELADO'),
(4, 1, 1, 2, 8, 16, 1, 'CANCELADO');
SET IDENTITY_INSERT ser_hab OFF;
GO

-- Estructura de tabla para la tabla `tipo_habi`
IF OBJECT_ID('tipo_habi', 'U') IS NULL
CREATE TABLE tipo_habi (
    id_tipo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre_tipo VARCHAR(100) NOT NULL,
    descrip_tipo VARCHAR(100) NOT NULL
);
GO

-- Volcado de datos para la tabla `tipo_habi`
SET IDENTITY_INSERT tipo_habi ON;
INSERT INTO tipo_habi (id_tipo, nombre_tipo, descrip_tipo) VALUES
(1, 'Simple', 'CON UNA SOLA CAMA TELEVISION Y BAÑO PRIVADO'),
(2, 'BOBLE BAÑO PRIVADO', 'baño privado television');
SET IDENTITY_INSERT tipo_habi OFF;
GO

-- Estructura de tabla para la tabla `usuario`
IF OBJECT_ID('usuario', 'U') IS NULL
CREATE TABLE usuario (
    id_user INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    tipo_user VARCHAR(30) NULL,
    id_per INT NULL,
    estado_user VARCHAR(20) NULL,
    username VARCHAR(50) NULL,
    clave VARCHAR(50) NULL
);
GO

-- Indexes for usuario table
-- MySQL's KEY is equivalent to CREATE INDEX in SQL Server
CREATE INDEX IX_usuario_id_per ON usuario (id_per);
GO

-- Volcado de datos para la tabla `usuario`
SET IDENTITY_INSERT usuario ON;
INSERT INTO usuario (id_user, tipo_user, id_per, estado_user, username, clave) VALUES
(6, 'ADMINISTRADOR', 6, 'HABILITADO', 'roger', '81dc9bdb52d04dc20036dbd8313ed055');
SET IDENTITY_INSERT usuario OFF;
GO