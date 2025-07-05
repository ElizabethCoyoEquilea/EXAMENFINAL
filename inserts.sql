
-- Crear tabla bloque
CREATE TABLE bloque (
    id_bloque INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(50) NOT NULL
);

-- Crear tabla piso
CREATE TABLE piso (
    id_piso INT PRIMARY KEY IDENTITY(1,1),
    numero INT NOT NULL
);

-- INSERTs para la tabla bloque
INSERT INTO bloque (nombre) VALUES
('Bloque A'),
('Bloque B'),
('Bloque C'),
('Bloque D'),
('Bloque E');

select * from bloque;

-- INSERTs para la tabla piso

select * from piso;

CREATE TABLE calendario (
    fecha DATE PRIMARY KEY,
    dia_semana NVARCHAR(20),        -- Lunes, Martes, etc.
    es_laborable BIT NOT NULL,      -- 1 = el hotel atiende ese día, 0 = no atiende
    observacion NVARCHAR(255)       -- Ej: "Feriado nacional", "Mantenimiento", etc.
);
select * from calendario;
CREATE OR ALTER PROCEDURE sp_llenar_calendario
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fecha_actual DATE = @fecha_inicio;
    DECLARE @dia_semana NVARCHAR(20);
    DECLARE @es_laborable BIT;
    DECLARE @dia INT;

    WHILE @fecha_actual <= @fecha_fin
    BEGIN
        SET @dia = DATEPART(WEEKDAY, @fecha_actual);

        -- Convertir día de la semana al nombre en español (ajustado a SET DATEFIRST 1)
        -- DATEFIRST 1 hace que el lunes sea 1 y domingo 7
        SET DATEFIRST 1;
        SET @dia = DATEPART(WEEKDAY, @fecha_actual);
        SET @dia_semana = CASE @dia
                            WHEN 1 THEN 'Lunes'
                            WHEN 2 THEN 'Martes'
                            WHEN 3 THEN 'Miércoles'
                            WHEN 4 THEN 'Jueves'
                            WHEN 5 THEN 'Viernes'
                            WHEN 6 THEN 'Sábado'
                            WHEN 7 THEN 'Domingo'
                          END;

        -- Determinar si es laborable (lunes a viernes = 1, sábado y domingo = 0)
        SET @es_laborable = CASE 
                                WHEN @dia IN (6, 7) THEN 0
                                ELSE 1
                            END;

        -- Insertar solo si no existe ya la fecha
        IF NOT EXISTS (SELECT 1 FROM calendario WHERE fecha = @fecha_actual)
        BEGIN
            INSERT INTO calendario (fecha, dia_semana, es_laborable, observacion)
            VALUES (@fecha_actual, @dia_semana, @es_laborable, NULL);
        END

        SET @fecha_actual = DATEADD(DAY, 1, @fecha_actual);
    END
END;

declare @fin date = getdate()
EXEC sp_llenar_calendario '2025-05-01', @fin;
--RESERVACION 
select * from reservacion;
delete from reservacion;
DBCC CHECKIDENT ('reservacion', RESEED, 0);

--ACUMULADOR
select * from acumulador;
delete from acumulador;
DBCC CHECKIDENT ('acumulador', RESEED, 0);
INSERT INTO acumulador (id_hab, id_cli) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30),
(31, 31),
(32, 32),
(33, 33),
(34, 34),
(35, 35),
(36, 36),
(37, 37),
(38, 38),
(39, 39),
(40, 40),
(41, 41),
(42, 42),
(43, 43),
(44, 44),
(45, 45),
(46, 46),
(47, 47),
(48, 48),
(49, 49),
(50, 50);

--SERVICIO HABITACION
select * from ser_hab;
delete from ser_hab;
DBCC CHECKIDENT ('ser_hab', RESEED, 0);
INSERT INTO ser_hab (id_hab, id_ser, cant_ser, costo_ser, costo_total, num_asig_ser, estado_ser, id_user) VALUES
(1, 6, 5, 219, 1095.00, 2000, 'realizado', 1),
(2, 6, 5, 298, 1490.00, 2001, 'realizado', 2),
(3, 3, 4, 282, 1128.00, 2002, 'realizado', 3),
(4, 4, 1, 207, 207.00, 2003, 'cancelado', 4),
(5, 2, 2, 165, 330.00, 2004, 'realizado', 5),
(6, 4, 2, 286, 572.00, 2005, 'solicitado', 1),
(7, 10, 3, 286, 858.00, 2006, 'solicitado', 2),
(8, 3, 2, 278, 556.00, 2007, 'cancelado', 3),
(9, 6, 5, 86, 430.00, 2008, 'cancelado', 4),
(10, 7, 5, 148, 740.00, 2009, 'solicitado', 5),
(11, 7, 3, 247, 741.00, 2010, 'solicitado', 1),
(12, 5, 4, 132, 528.00, 2011, 'solicitado', 2),
(13, 2, 2, 54, 108.00, 2012, 'solicitado', 3),
(14, 4, 2, 189, 378.00, 2013, 'realizado', 4),
(15, 9, 1, 225, 225.00, 2014, 'cancelado', 5),
(16, 4, 2, 56, 112.00, 2015, 'realizado', 1),
(17, 6, 5, 116, 580.00, 2016, 'cancelado', 2),
(18, 1, 3, 268, 804.00, 2017, 'cancelado', 3),
(19, 8, 5, 207, 1035.00, 2018, 'cancelado', 4),
(20, 2, 4, 243, 972.00, 2019, 'solicitado', 5),
(21, 3, 1, 204, 204.00, 2020, 'realizado', 1),
(22, 8, 2, 158, 316.00, 2021, 'cancelado', 2),
(23, 1, 4, 230, 920.00, 2022, 'cancelado', 3),
(24, 9, 1, 190, 190.00, 2023, 'cancelado', 4),
(25, 8, 3, 144, 432.00, 2024, 'realizado', 5),
(26, 7, 4, 121, 484.00, 2025, 'realizado', 1),
(27, 2, 5, 223, 1115.00, 2026, 'cancelado', 2),
(28, 6, 3, 276, 828.00, 2027, 'cancelado', 3),
(29, 7, 4, 184, 736.00, 2028, 'realizado', 4),
(30, 1, 2, 116, 232.00, 2029, 'realizado', 5),
(31, 10, 2, 88, 176.00, 2030, 'realizado', 1),
(32, 4, 1, 76, 76.00, 2031, 'solicitado', 2),
(33, 6, 4, 228, 912.00, 2032, 'solicitado', 3),
(34, 2, 4, 69, 276.00, 2033, 'solicitado', 4),
(35, 4, 2, 250, 500.00, 2034, 'realizado', 5),
(36, 1, 1, 157, 157.00, 2035, 'cancelado', 1),
(37, 10, 4, 243, 972.00, 2036, 'solicitado', 2),
(38, 10, 3, 294, 882.00, 2037, 'cancelado', 3),
(39, 10, 5, 274, 1370.00, 2038, 'realizado', 4),
(40, 3, 4, 186, 744.00, 2039, 'realizado', 5),
(41, 7, 3, 268, 804.00, 2040, 'realizado', 1),
(42, 8, 4, 109, 436.00, 2041, 'solicitado', 2),
(43, 5, 1, 113, 113.00, 2042, 'realizado', 3),
(44, 6, 5, 141, 705.00, 2043, 'solicitado', 4),
(45, 6, 1, 158, 158.00, 2044, 'realizado', 5),
(46, 5, 2, 286, 572.00, 2045, 'cancelado', 1),
(47, 7, 4, 206, 824.00, 2046, 'solicitado', 2),
(48, 4, 4, 102, 408.00, 2047, 'realizado', 3),
(49, 5, 2, 208, 416.00, 2048, 'solicitado', 4),
(50, 2, 3, 63, 189.00, 2049, 'solicitado', 5);



--ASIGNACION HABITACION
select * from asignacion_hab;
delete from asignacion_hab;
DBCC CHECKIDENT ('asignacion_hab', RESEED, 0);
INSERT INTO asignacion_hab (id_hab, id_cli, fecha_ent, fecha_sal, num_dias, costo_total, estado_asig_hab, num_asig, id_user) VALUES
(1, 1, '2025-05-01', '2025-05-19', 7, 1000, 'pendiente', 1000, 1);
/*
(2, 2, '2022-03-24', '2022-03-28', 4, 1000, 'pendiente', 1001, 2),
(3, 3, '2023-09-25', '2023-09-28', 3, 1000, 'pendiente', 1002, 3),
(4, 4, '2024-06-14', '2024-06-18', 4, 1000, 'pendiente', 1003, 4),
(5, 5, '2023-11-21', '2023-11-23', 2, 1000, 'pendiente', 1004, 5),
(6, 6, '2021-06-09', '2021-06-13', 4, 1000, 'pendiente', 1005, 1),
(7, 7, '2024-01-04', '2024-01-09', 5, 1000, 'pendiente', 1006, 2),
(8, 8, '2024-11-02', '2024-11-03', 1, 1000, 'pendiente', 1007, 3),
(9, 9, '2021-05-31', '2021-06-04', 4, 1000, 'pendiente', 1008, 4),
(10, 10, '2020-03-15', '2020-03-22', 7, 1000, 'pendiente', 1009, 5),
(11, 11, '2024-09-03', '2024-09-07', 4, 1000, 'pendiente', 1010, 1),
(12, 12, '2022-03-18', '2022-03-23', 5, 1000, 'pendiente', 1011, 2),
(13, 13, '2021-07-28', '2021-07-29', 1, 1000, 'pendiente', 1012, 3),
(14, 14, '2020-03-02', '2020-03-05', 3, 1000, 'pendiente', 1013, 4),
(15, 15, '2020-11-17', '2020-11-19', 2, 1000, 'pendiente', 1014, 5),
(16, 16, '2024-01-09', '2024-01-16', 7, 1000, 'pendiente', 1015, 1),
(17, 17, '2020-11-06', '2020-11-11', 5, 1000, 'pendiente', 1016, 2),
(18, 18, '2023-08-15', '2023-08-21', 6, 1000, 'pendiente', 1017, 3),
(19, 19, '2024-03-06', '2024-03-13', 7, 1000, 'pendiente', 1018, 4),
(20, 20, '2021-01-24', '2021-01-26', 2, 1000, 'pendiente', 1019, 5),
(21, 21, '2021-03-09', '2021-03-13', 4, 1000, 'pendiente', 1020, 1),
(22, 22, '2024-08-04', '2024-08-06', 2, 1000, 'pendiente', 1021, 2),
(23, 23, '2024-08-29', '2024-08-30', 1, 1000, 'pendiente', 1022, 3),
(24, 24, '2022-09-12', '2022-09-18', 6, 1000, 'pendiente', 1023, 4),
(25, 25, '2022-12-29', '2023-01-01', 3, 1000, 'pendiente', 1024, 5),
(26, 26, '2024-08-18', '2024-08-20', 2, 1000, 'pendiente', 1025, 1),
(27, 27, '2021-11-03', '2021-11-07', 4, 1000, 'pendiente', 1026, 2),
(28, 28, '2023-06-13', '2023-06-17', 4, 1000, 'pendiente', 1027, 3),
(29, 29, '2023-12-27', '2023-12-29', 2, 1000, 'pendiente', 1028, 4),
(30, 30, '2021-11-11', '2021-11-15', 4, 1000, 'pendiente', 1029, 5),
(31, 31, '2022-02-11', '2022-02-18', 7, 1000, 'pendiente', 1030, 1),
(32, 32, '2021-02-18', '2021-02-25', 7, 1000, 'pendiente', 1031, 2),
(33, 33, '2023-09-15', '2023-09-19', 4, 1000, 'pendiente', 1032, 3),
(34, 34, '2020-12-06', '2020-12-13', 7, 1000, 'pendiente', 1033, 4),
(35, 35, '2024-02-08', '2024-02-09', 1, 1000, 'pendiente', 1034, 5),
(36, 36, '2020-04-05', '2020-04-09', 4, 1000, 'pendiente', 1035, 1),
(37, 37, '2020-03-12', '2020-03-16', 4, 1000, 'pendiente', 1036, 2),
(38, 38, '2024-06-16', '2024-06-22', 6, 1000, 'pendiente', 1037, 3),
(39, 39, '2022-04-22', '2022-04-24', 2, 1000, 'pendiente', 1038, 4),
(40, 40, '2024-03-18', '2024-03-25', 7, 1000, 'pendiente', 1039, 5),
(41, 41, '2022-10-05', '2022-10-08', 3, 1000, 'pendiente', 1040, 1),
(42, 42, '2021-11-20', '2021-11-24', 4, 1000, 'pendiente', 1041, 2),
(43, 43, '2021-09-07', '2021-09-10', 3, 1000, 'pendiente', 1042, 3),
(44, 44, '2024-12-27', '2024-12-29', 2, 1000, 'pendiente', 1043, 4),
(45, 45, '2024-02-13', '2024-02-15', 2, 1000, 'pendiente', 1044, 5),
(46, 46, '2023-08-07', '2023-08-11', 4, 1000, 'pendiente', 1045, 1),
(47, 47, '2023-02-11', '2023-02-16', 5, 1000, 'pendiente', 1046, 2),
(48, 48, '2021-04-13', '2021-04-18', 5, 1000, 'pendiente', 1047, 3),
(49, 49, '2023-05-15', '2023-05-21', 6, 1000, 'pendiente', 1048, 4),
(50, 50, '2022-04-15', '2022-04-18', 3, 1000, 'pendiente', 1049, 5);

select * from habitacion;

--RESERVA
select * from reserva;
delete from reserva;
DBCC CHECKIDENT ('reserva', RESEED, 0);
INSERT INTO reserva (id_hab, id_cli, fecha_in, fecha_fin, estado_res, id_user) VALUES
(1, 1, '2022-11-22', '2022-11-29', 'pendiente', 1),
(2, 2, '2022-03-24', '2022-03-28', 'pendiente', 2),
(3, 3, '2023-09-25', '2023-09-28', 'pendiente', 3),
(4, 4, '2024-06-14', '2024-06-18', 'pendiente', 4),
(5, 5, '2023-11-21', '2023-11-23', 'pendiente', 5),
(6, 6, '2021-06-09', '2021-06-13', 'pendiente', 1),
(7, 7, '2024-01-04', '2024-01-09', 'pendiente', 2),
(8, 8, '2024-11-02', '2024-11-03', 'pendiente', 3),
(9, 9, '2021-05-31', '2021-06-04', 'pendiente', 4),
(10, 10, '2020-03-15', '2020-03-22', 'pendiente', 5),
(11, 11, '2024-09-03', '2024-09-07', 'pendiente', 1),
(12, 12, '2022-03-18', '2022-03-23', 'pendiente', 2),
(13, 13, '2021-07-28', '2021-07-29', 'pendiente', 3),
(14, 14, '2020-03-02', '2020-03-05', 'pendiente', 4),
(15, 15, '2020-11-17', '2020-11-19', 'pendiente', 5),
(16, 16, '2024-01-09', '2024-01-16', 'pendiente', 1),
(17, 17, '2020-11-06', '2020-11-11', 'pendiente', 2),
(18, 18, '2023-08-15', '2023-08-21', 'pendiente', 3),
(19, 19, '2024-03-06', '2024-03-13', 'pendiente', 4),
(20, 20, '2021-01-24', '2021-01-26', 'pendiente', 5),
(21, 21, '2021-03-09', '2021-03-13', 'pendiente', 1),
(22, 22, '2024-08-04', '2024-08-06', 'pendiente', 2),
(23, 23, '2024-08-29', '2024-08-30', 'pendiente', 3),
(24, 24, '2022-09-12', '2022-09-18', 'pendiente', 4),
(25, 25, '2022-12-29', '2023-01-01', 'pendiente', 5),
(26, 26, '2024-08-18', '2024-08-20', 'pendiente', 1),
(27, 27, '2021-11-03', '2021-11-07', 'pendiente', 2),
(28, 28, '2023-06-13', '2023-06-17', 'pendiente', 3),
(29, 29, '2023-12-27', '2023-12-29', 'pendiente', 4),
(30, 30, '2021-11-11', '2021-11-15', 'pendiente', 5),
(31, 31, '2022-02-11', '2022-02-18', 'pendiente', 1),
(32, 32, '2021-02-18', '2021-02-25', 'pendiente', 2),
(33, 33, '2023-09-15', '2023-09-19', 'pendiente', 3),
(34, 34, '2020-12-06', '2020-12-13', 'pendiente', 4),
(35, 35, '2024-02-08', '2024-02-09', 'pendiente', 5),
(36, 36, '2020-04-05', '2020-04-09', 'pendiente', 1),
(37, 37, '2020-03-12', '2020-03-16', 'pendiente', 2),
(38, 38, '2024-06-16', '2024-06-22', 'pendiente', 3),
(39, 39, '2022-04-22', '2022-04-24', 'pendiente', 4),
(40, 40, '2024-03-18', '2024-03-25', 'pendiente', 5),
(41, 41, '2022-10-05', '2022-10-08', 'pendiente', 1),
(42, 42, '2021-11-20', '2021-11-24', 'pendiente', 2),
(43, 43, '2021-09-07', '2021-09-10', 'pendiente', 3),
(44, 44, '2024-12-27', '2024-12-29', 'pendiente', 4),
(45, 45, '2024-02-13', '2024-02-15', 'pendiente', 5),
(46, 46, '2023-08-07', '2023-08-11', 'pendiente', 1),
(47, 47, '2023-02-11', '2023-02-16', 'pendiente', 2),
(48, 48, '2021-04-13', '2021-04-18', 'pendiente', 3),
(49, 49, '2023-05-15', '2023-05-21', 'pendiente', 4),
(50, 50, '2022-04-15', '2022-04-18', 'pendiente', 5);


-- CLIENTE
select * from clientes;
delete from clientes;
DBCC CHECKIDENT ('clientes', RESEED, 0);
INSERT INTO clientes (ap_cli, nom_cli, tipo_docu, nro_doc_cli, celular_cli, procedencia_cli, fecha_nac_cli, estado_cli) VALUES
('Gómez', 'María', 'CI', '3456789', '71234567', 'Santa Cruz', '1990-04-15', 'activo'),
('Fernández', 'Luis', 'CI', '1234567', '71234568', 'La Paz', '1985-07-20', 'activo'),
('Rojas', 'Ana', 'Pasaporte', 'X123456', '71234569', 'Cochabamba', '1993-09-10', 'activo'),
('Ramírez', 'Carlos', 'CI', '2345678', '71234570', 'Tarija', '1987-12-05', 'activo'),
('Suárez', 'Lucía', 'CI', '4567890', '71234571', 'Oruro', '1991-01-25', 'activo'),
('Martínez', 'Jorge', 'Pasaporte', 'X987654', '71234572', 'Beni', '1992-03-17', 'activo'),
('Lopez', 'Elena', 'CI', '8765432', '71234573', 'Pando', '1994-06-22', 'activo'),
('Vargas', 'Miguel', 'CI', '5678901', '71234574', 'Chuquisaca', '1989-08-19', 'activo'),
('Torres', 'Paola', 'CI', '1234598', '71234575', 'Potosí', '1995-11-30', 'activo'),
('Gutiérrez', 'Daniel', 'CI', '9876543', '71234576', 'La Paz', '1986-02-13', 'activo'),
('Navarro', 'Sandra', 'CI', '3456781', '71234577', 'Cochabamba', '1990-05-05', 'activo'),
('Rivera', 'Javier', 'Pasaporte', 'A112233', '71234578', 'Santa Cruz', '1988-10-11', 'activo'),
('Ortiz', 'Camila', 'CI', '7654321', '71234579', 'Tarija', '1993-07-28', 'activo'),
('Castro', 'Hugo', 'CI', '6543210', '71234580', 'Oruro', '1991-09-02', 'activo'),
('Peña', 'Sofía', 'CI', '4321098', '71234581', 'Pando', '1992-12-16', 'activo'),
('Reyes', 'Eduardo', 'Pasaporte', 'B445566', '71234582', 'Chuquisaca', '1987-11-03', 'activo'),
('Morales', 'Valeria', 'CI', '5432109', '71234583', 'Potosí', '1990-01-19', 'activo'),
('Aguilar', 'Sebastián', 'CI', '2345671', '71234584', 'La Paz', '1985-06-23', 'activo'),
('Medina', 'Fernanda', 'CI', '9876541', '71234585', 'Santa Cruz', '1994-08-30', 'activo'),
('Silva', 'Andrés', 'Pasaporte', 'C778899', '71234586', 'Cochabamba', '1992-03-08', 'activo'),
('Salazar', 'Natalia', 'CI', '6543219', '71234587', 'Oruro', '1993-11-27', 'activo'),
('Arce', 'Leonardo', 'CI', '8765431', '71234588', 'Tarija', '1989-10-14', 'activo'),
('Flores', 'Gabriela', 'Pasaporte', 'D334455', '71234589', 'Chuquisaca', '1991-05-06', 'activo'),
('Paredes', 'Raúl', 'CI', '7654320', '71234590', 'La Paz', '1986-04-29', 'activo'),
('Campos', 'Isabel', 'CI', '5432198', '71234591', 'Santa Cruz', '1995-01-31', 'activo'),
('Quispe', 'Diego', 'CI', '3210987', '71234592', 'Potosí', '1990-06-15', 'activo'),
('Téllez', 'Mónica', 'Pasaporte', 'E556677', '71234593', 'Oruro', '1988-08-03', 'activo'),
('Vega', 'Esteban', 'CI', '1234589', '71234594', 'Beni', '1991-10-21', 'activo'),
('Sánchez', 'Julieta', 'CI', '9876532', '71234595', 'Cochabamba', '1992-07-01', 'activo'),
('Luna', 'Mauricio', 'Pasaporte', 'F998877', '71234596', 'Tarija', '1987-03-04', 'activo'),
('Aliaga', 'Verónica', 'CI', '4321097', '71234597', 'Santa Cruz', '1993-12-09', 'activo'),
('Calderón', 'Bruno', 'CI', '3456798', '71234598', 'La Paz', '1990-02-24', 'activo'),
('Espinoza', 'Liliana', 'CI', '6543209', '71234599', 'Cochabamba', '1994-04-18', 'activo'),
('Zapata', 'Rodrigo', 'Pasaporte', 'G112244', '71234600', 'Pando', '1989-09-07', 'activo'),
('Ríos', 'Cecilia', 'CI', '5678912', '71234601', 'Tarija', '1995-06-20', 'activo'),
('Mamani', 'Óscar', 'CI', '6789123', '71234602', 'Oruro', '1992-01-11', 'activo'),
('Villarroel', 'Daniela', 'Pasaporte', 'H556699', '71234603', 'Chuquisaca', '1990-08-25', 'activo'),
('Coronel', 'Renato', 'CI', '7891234', '71234604', 'Santa Cruz', '1986-10-05', 'activo'),
('Delgado', 'Florencia', 'CI', '8912345', '71234605', 'La Paz', '1991-03-22', 'activo'),
('García', 'Felipe', 'CI', '9123456', '71234606', 'Cochabamba', '1988-12-12', 'activo'),
('López', 'Angela', 'Pasaporte', 'I445577', '71234607', 'Potosí', '1993-04-14', 'activo'),
('Paz', 'Ignacio', 'CI', '1098765', '71234608', 'Tarija', '1990-11-01', 'activo'),
('Méndez', 'Patricia', 'CI', '2087654', '71234609', 'Beni', '1989-07-26', 'activo'),
('Herrera', 'Lucas', 'CI', '3098765', '71234610', 'Santa Cruz', '1992-09-19', 'activo'),
('Soria', 'Mariela', 'Pasaporte', 'J223344', '71234611', 'La Paz', '1991-06-03', 'activo'),
('Villarroel', 'Cristian', 'CI', '4567891', '71234612', 'Chuquisaca', '1987-01-07', 'activo'),
('Cardozo', 'Melina', 'CI', '5678910', '71234613', 'Pando', '1993-05-30', 'activo'),
('Ribera', 'Kevin', 'CI', '6789102', '71234614', 'Oruro', '1990-03-16', 'activo'),
('Zegarra', 'Fiorella', 'CI', '7891023', '71234615', 'Tarija', '1988-02-09', 'activo'),
('Lima', 'Jonathan', 'Pasaporte', 'K667788', '71234616', 'Santa Cruz', '1995-09-13', 'activo');

-- SERVICIOS
select * from servicios;
delete from servicios;
DBCC CHECKIDENT ('servicios', RESEED, 0);
INSERT INTO servicios (nombre_ser, descripcion_ser, costo_ser, ent_ser, sal_ser, saldo_ser) VALUES
('Lavandería', 'Servicio de lavado y planchado de ropa', 50, 10, 2, 8),
('Spa', 'Acceso al spa del hotel por 1 hora', 120, 15, 5, 10),
('Room Service', 'Entrega de alimentos y bebidas a la habitación', 30, 20, 8, 12),
('WiFi Premium', 'Acceso a internet de alta velocidad por 24h', 25, 25, 10, 15),
('Estacionamiento', 'Uso del parqueo privado por día', 40, 30, 18, 12),
('Gimnasio', 'Acceso al gimnasio durante el día', 20, 40, 25, 15),
('Desayuno buffet', 'Desayuno buffet en el restaurante del hotel', 35, 50, 30, 20),
('Traslado aeropuerto', 'Servicio de transporte desde o hacia el aeropuerto', 100, 8, 3, 5),
('Masaje', 'Masaje relajante de 45 minutos', 90, 12, 7, 5),
('Tours turísticos', 'Excursión guiada a puntos turísticos locales', 150, 6, 2, 4);

-- HABITACIONES
select * from habitacion;
delete from habitacion;
DBCC CHECKIDENT ('habitacion', RESEED, 0);
INSERT INTO habitacion (num_habi, piso, costo, id_tipo, num_camas, estado_asig, bloque) VALUES
('HAB001', 1, '250', 1, 2, 'libre', 2);
/*
('HAB002', 2, '320', 2, 1, 'ocupado', 1),
('HAB003', 3, '400', 1, 3, 'limpieza', 3),
('HAB004', 4, '180', 3, 1, 'libre', 5),
('HAB005', 5, '220', 2, 2, 'ocupado', 4),
('HAB006', 1, '310', 1, 2, 'limpieza', 2),
('HAB007', 2, '270', 3, 1, 'libre', 1),
('HAB008', 3, '150', 2, 3, 'ocupado', 5),
('HAB009', 4, '360', 1, 2, 'libre', 3),
('HAB010', 5, '330', 3, 1, 'ocupado', 4),
('HAB011', 1, '190', 1, 1, 'limpieza', 1),
('HAB012', 2, '210', 2, 2, 'libre', 2),
('HAB013', 3, '450', 3, 3, 'ocupado', 5),
('HAB014', 4, '240', 1, 1, 'limpieza', 3),
('HAB015', 5, '290', 2, 2, 'libre', 4),
('HAB016', 1, '410', 3, 3, 'ocupado', 2),
('HAB017', 2, '170', 1, 2, 'libre', 5),
('HAB018', 3, '390', 2, 1, 'limpieza', 3),
('HAB019', 4, '260', 3, 3, 'ocupado', 1),
('HAB020', 5, '280', 1, 2, 'libre', 2),
('HAB021', 1, '340', 2, 1, 'ocupado', 3),
('HAB022', 2, '130', 3, 2, 'limpieza', 4),
('HAB023', 3, '370', 1, 1, 'libre', 5),
('HAB024', 4, '300', 2, 2, 'ocupado', 2),
('HAB025', 5, '230', 3, 3, 'libre', 1),
('HAB026', 1, '200', 1, 2, 'ocupado', 4),
('HAB027', 2, '260', 2, 1, 'limpieza', 3),
('HAB028', 3, '380', 3, 3, 'libre', 5),
('HAB029', 4, '290', 1, 2, 'ocupado', 1),
('HAB030', 5, '310', 2, 2, 'limpieza', 2),
('HAB031', 1, '270', 3, 1, 'libre', 3),
('HAB032', 2, '210', 1, 3, 'ocupado', 4),
('HAB033', 3, '350', 2, 1, 'limpieza', 1),
('HAB034', 4, '190', 3, 2, 'libre', 5),
('HAB035', 5, '250', 1, 3, 'ocupado', 3),
('HAB036', 1, '300', 2, 2, 'libre', 2),
('HAB037', 2, '160', 3, 1, 'limpieza', 1),
('HAB038', 3, '440', 1, 2, 'ocupado', 4),
('HAB039', 4, '350', 2, 3, 'libre', 3),
('HAB040', 5, '290', 3, 1, 'ocupado', 5),
('HAB041', 1, '210', 1, 2, 'libre', 2),
('HAB042', 2, '280', 2, 1, 'ocupado', 1),
('HAB043', 3, '390', 3, 3, 'limpieza', 4),
('HAB044', 4, '180', 1, 1, 'libre', 3),
('HAB045', 5, '260', 2, 2, 'ocupado', 5),
('HAB046', 1, '220', 3, 2, 'limpieza', 4),
('HAB047', 2, '300', 1, 3, 'libre', 1),
('HAB048', 3, '330', 2, 2, 'ocupado', 2),
('HAB049', 4, '240', 3, 1, 'limpieza', 3),
('HAB050', 5, '310', 1, 2, 'libre', 5);
*/

-- TIPO HABITACION
select * from tipo_habi;
delete from tipo_habi;
DBCC CHECKIDENT ('tipo_habi', RESEED, 0);
INSERT INTO tipo_habi (nombre_tipo, descrip_tipo) VALUES
('Individual', 'Habitación para una persona con cama individual'),
('Doble', 'Habitación para dos personas con cama doble o dos individuales'),
('Suite', 'Habitación amplia con sala, baño privado y comodidades premium');

--USUARIO
select * from usuario;
delete from usuario;
DBCC CHECKIDENT ('usuario', RESEED, 0);
INSERT INTO usuario (tipo_user, id_per, estado_user, username, clave) VALUES
('admin', 1, 'activo', 'maria.gomez', 'clave123'),
('gerente', 2, 'activo', 'luis.fernandez', 'clave123'),
('recepcionista', 3, 'activo', 'ana.rojas', 'clave123'),
('recepcionista', 4, 'activo', 'carlos.ramirez', 'clave123'),
('recepcionista', 5, 'activo', 'lucia.suarez', 'clave123');

--PERSONAL
select * from personal;
delete from personal;
DBCC CHECKIDENT ('personal', RESEED, 0);
INSERT INTO personal (ci_per, apellidos_per, nombres_per, celular_per, direccion_per, estado_per, email_per, est_user) VALUES
('12345678', 'Gómez Pérez', 'María', '71230001', 'Av. Banzer #123', 'activo', 'maria.gomez@mail.com', 'SI'),
('23456789', 'Fernández Lima', 'Luis', '71230002', 'Calle Sucre #456', 'activo', 'luis.fernandez@mail.com', 'SI'),
('34567890', 'Rojas Castro', 'Ana', '71230003', 'Av. Cañoto #789', 'activo', 'ana.rojas@mail.com', 'SI'),
('45678901', 'Ramírez Soto', 'Carlos', '71230004', 'Calle Aroma #101', 'activo', 'carlos.ramirez@mail.com', 'SI'),
('56789012', 'Suárez López', 'Lucía', '71230005', 'Av. Irala #202', 'activo', 'lucia.suarez@mail.com', 'SI');



