-- DIMFECHA
CREATE TABLE dimFecha (
Fecha date primary key not null,
anio smallint,
semestre tinyint,
trimestre tinyint,
mes varchar(30),
quincena tinyint,
dia varchar(30)
);
select * from dimFecha;
delete from dimFecha;
drop table dimFecha;

CREATE OR ALTER PROCEDURE RellenarDimFecha
    @FechaIni DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Validación básica
    IF @FechaFin < @FechaIni
    BEGIN
        RAISERROR('La fecha final no puede ser menor que la fecha inicial.', 16, 1);
        RETURN;
    END

    DECLARE @FechaActual DATE = @FechaIni;
    SET LANGUAGE Spanish;

    WHILE @FechaActual <= @FechaFin
    BEGIN
        -- Solo insertar si la fecha NO existe en la tabla
        IF NOT EXISTS (
            SELECT 1 FROM dimFecha WHERE Fecha = @FechaActual
        )
        BEGIN
            INSERT INTO dimFecha (Fecha, anio, semestre, trimestre, mes, quincena, dia)
            SELECT
                @FechaActual AS Fecha,
                YEAR(@FechaActual) AS anio,
                CASE 
                    WHEN MONTH(@FechaActual) BETWEEN 1 AND 6 THEN 1
                    ELSE 2
                END AS semestre,
                DATEPART(QUARTER, @FechaActual) AS trimestre,
                DATENAME(MONTH, @FechaActual) AS mes,
                CASE 
                    WHEN DAY(@FechaActual) <= 15 THEN 1
                    ELSE 2
                END AS quincena,
                DATENAME(WEEKDAY, @FechaActual) AS dia;
        END;

        SET @FechaActual = DATEADD(DAY, 1, @FechaActual);
    END
END;

DECLARE @FIN DATE = GETDATE();

exec [dbo].[RellenarDimFecha] '2025-05-01', @FIN;


--TIPO HABITACION
create table dimTipoHabitacion(
idTipoHabitacion int primary key,
nombre varchar(max),
);
select * from dimTipoHabitacion;

--LOCALIZACION
create table dimLocalizacion(
idLocalizacion int primary key,
bloque varchar(max),
piso varchar(max),
);
select * from dimLocalizacion;


create table factRegistro(
idLocalizacion int,
idTipoHabitacion int,
idFecha int,
Ocupado int,
);
select * from factRegistro;
