/*store procedure carga hora por dia*/
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

/*store procedure carga hora por semana*/
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

/*store procedure carga hora por mes*/
delimiter $$
create procedure RendicionHorasMes(inicial date, final date, m_hora decimal
(5,2), m_id_proyecto int, m_id_participante int)
begin
    insert into carga_mensual
        (m_inicial, m_final, hora, id_proyecto, id_participante)
    VALUES
        (inicial, final, m_hora, m_id_proyecto, m_id_participante);
end
$$
