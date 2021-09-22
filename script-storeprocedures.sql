


/*store procedure carga hora por dia
delimiter $$
create procedure RendicionHorasDia(in d_dia date, d_hora decimal
(5,2), d_id_proyecto int, d_id_participante int)
begin
    insert into carga_diaria
        (dia, hora, id_proyecto, id_participante)
    VALUES
        (d_dia, d_hora, d_id_proyecto, d_id_participante);
end
$$

/*store procedure carga hora por semana
delimiter $$
create procedure RendicionHorasSemana(inicial date, final date, s_hora decimal
(5,2), s_id_proyecto int, s_id_participante int)
begin
    insert into carga_semanal
        (s_inicial, s_final, hora, id_proyecto, id_participante)
    VALUES
        (inicial, final, s_hora, s_id_proyecto, s_id_participante);
end
$$

/*store procedure carga hora por mes
delimiter $$
create procedure RendicionHorasMes(inicial date, final date, m_hora decimal
(5,2), m_id_proyecto int, m_id_participante int)
begin
    insert into carga_mensual
        (m_inicial, m_final, hora, id_proyecto, id_participante)
    VALUES
        (inicial, final, m_hora, m_id_proyecto, m_id_participante);
end
$$*/

delimiter $$
create procedure RendicionHoras(in d_inicial date, c_dias int, c_horas decimal
(5,2),d_id_proyecto int, d_id_participante int)
BEGIN
DECLARE cont INT;
SET cont:=0;
WHILE cont<c_dias DO
WHILE ((DAYOFWEEK(d_inicial)=1) or (DAYOFWEEK(d_inicial)=7)) DO
SET d_inicial:=(DATE_ADD(d_inicial, INTERVAL 1 DAY));
END
WHILE;
insert into carga_horas
(dia, hora, id_proyecto, id_participante)
VALUES
(d_inicial, c_horas, d_id_proyecto, d_id_participante);
SET d_inicial:=(DATE_ADD(d_inicial, INTERVAL 1 DAY));
SET cont:= cont +1;
END
WHILE;
END
$$

describe carga_horas;
DROP PROCEDURE RendicionHoras;

call RendicionHoras
('20210921',5,8,1,1);
call RendicionHoras
('20210901',20,8,1,1);

/*store procedure para calcular liquidacion mensual*/
delimiter $$
create procedure CalcularLiquidacionMensual (in usuario int, cliente int, proyecto int, mes int)
BEGIN
    DECLARE suma1 DECIMAL;
DECLARE suma2 DECIMAL;
DECLARE suma3 DECIMAL;

if usuario <=>5
THEN

set
suma1:
=
(SELECT ifNULL(SUM(hora),0)
FROM carga_diaria
WHERE id_proyecto=proyecto AND MONTH(dia)=mes);
set
suma2:
=
(SELECT ifNULL(SUM(hora),0)
FROM carga_semanal
WHERE id_proyecto=proyecto AND MONTH(s_inicial)=mes AND MONTH(s_final)=mes);
set
suma3:
=
(SELECT ifNULL(SUM(hora),0)
FROM carga_mensual
WHERE id_proyecto=proyecto AND MONTH(m_inicial)=mes AND MONTH(m_final)=mes);

CREATE TABLE tabla_horas2
(
    id_cliente_t int,
    id_proyecto_t int,
    horas_d decimal default 0,
    horas_s decimal default 0,
    horas_m decimal default 0
);
insert into tabla_horas2
    (id_cliente_t, id_proyecto_t, horas_d, horas_s, horas_m)
VALUES
    (cliente, proyecto, suma1, suma2, suma3);
SELECT id_proyecto_t, id_cliente_t, sum(horas_d + horas_s + horas_m) as horas_mensuales
FROM tabla_horas2
GROUP BY id_proyecto_t, id_cliente_t;

END
IF;
END
$$

/*Store Procedure Calcular Diferencia*/
delimiter $
$
create procedure CalcularDiferencia (in usuario int, proyecto int, anio int)
BEGIN
    DECLARE suma1 DECIMAL;
DECLARE suma2 DECIMAL;
DECLARE suma3 DECIMAL;
DECLARE h_as DECIMAL;

if usuario <=>5
THEN

set
suma1:
=
(SELECT ifNULL(SUM(hora),0)
FROM carga_diaria
WHERE id_proyecto=proyecto AND YEAR(dia)=anio);
set
suma2:
=
(SELECT ifNULL(SUM(hora),0)
FROM carga_semanal
WHERE id_proyecto=proyecto AND YEAR(s_inicial)=anio AND YEAR(s_final)=anio);
set
suma3:
=
(SELECT ifNULL(SUM(hora),0)
FROM carga_mensual
WHERE id_proyecto=proyecto AND YEAR(m_inicial)=anio AND YEAR(m_final)=anio);
set
h_as:
=
(SELECT pack_horas
FROM proyecto
WHERE id=proyecto);

CREATE TABLE tabla_horas3
(
    id_proyecto_t int,
    horas_d decimal default 0,
    horas_s decimal default 0,
    horas_m decimal default 0,
    horas_a decimal default 0
);
insert into tabla_horas3
    (id_proyecto_t, horas_d, horas_s, horas_m,horas_a)
VALUES
    (proyecto, suma1, suma2, suma3, h_as);
SELECT id_proyecto_t, sum(horas_d + horas_s + horas_m) as horas_trabajadas, horas_a as horas_contratadas,
    (sum(horas_d + horas_s + horas_m)-horas_a) as horas_extra
FROM tabla_horas3
GROUP BY id_proyecto_t,horas_a;

END
IF;
END
$$
