/*
procedimiento que imprime los movimiento de la partida activa.
*/
SET SERVEROUTPUT ON
create or replace procedure p_mov
	is
	partida partida_activa.id_partida%type;
	mueven varchar2(9);
begin
	partida := f_partida_activa;
	if partida <> -1 then
		declare
			cursor moves is
			select movimiento, notacion
			from movimientos
			where id_partida = partida
			order by movimiento;
		begin
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.   Movimientos de la partida '||to_char(partida));
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.   numero movimiento   movimiento de   descripcion movimiento');
			dbms_output.put_line('.   -----------------   -------------   ----------------------');
			for mov in moves loop
				if mod(mov.movimiento,2) = 0 then
					mueven := 'Negras';
				else
					mueven := 'Blancas';
				end if;
				dbms_output.put_line('.    '||lpad(to_char(mov.movimiento), 16,' ')||lpad(mueven,16,' ')||lpad(to_char(mov.notacion),25,' '));
			end loop;
		end;
	else
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Aun no se ha definido una partida activa...');
	end if;
end;
/