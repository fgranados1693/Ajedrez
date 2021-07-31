set pages 66
set linesize 120
SET SERVEROUTPUT ON
create or replace procedure p_hist_partidas(apodo varchar2)
 is
	apodo2 partidas.nickname1%type := apodo;
	registrado number;
	jugador varchar2(47);
begin
	apodo2 := upper(apodo2);
	registrado := f_existe_nickname (apodo2);
	if registrado = 1 then
		jugador := f_full_name_otro(apodo2);
		declare
			cursor historico is
			select id_partida, fecha_inicio, fecha_fin, resultado
			from partidas
			where nickname1 = apodo2 or nickname2 = apodo2;
		begin
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.   Resumen de partidas en las que participa el jugador:');
			dbms_output.put_line('.   '||jugador);
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.     partida   fecha inicio   fecha finalizacion   resultado                          ');
			dbms_output.put_line('.   ---------   ------------   ------------------   ---------------------------------------------------------');
			for his in historico loop
			dbms_output.put_line('.   '||lpad(to_char(his.id_partida),9, ' ')||lpad(to_char(his.fecha_inicio), 15)||lpad(to_char(his.fecha_fin), 21)||'   '||rpad(his.resultado, 60, ' '));
			end loop;
		end;
	else
		dbms_output.put_line(chr(13));
		dbms_output.put_line('No existe el nickname que intenta ingresar, vuelva a intentarlo...');
	end if;
end;
/
