/*
Procedimiento que permite solicitar al jugador oponente el empate
*/
create or replace procedure p_empate
 is
	partida partida_activa.id_partida%type;
	jugador1 varchar2(47); -- nombre jugador 1
	jugador2 varchar2(47); -- nombre jugador 2
	mueven varchar2(7);
begin
	partida := f_partida_activa;
	if partida > 0 then
		mueven := f_mueve; -- se carga el color de pieza que mueve
		if mueven = 'Blancas' then
			jugador1 := f_full_name(1);
			jugador2 := f_full_name(2);
		else
			jugador1 := f_full_name(2);
			jugador2 := f_full_name(1);
		end if;
		dbms_output.put_line(chr(13));
		dbms_output.put_line('.     El jugador '||jugador1||'.');
		dbms_output.put_line('.     Solicita al jugador '||jugador2||' finalizar con empate');
		dbms_output.put_line('.     Si '||jugador2||' lo acepta debe ejecutar la siguiente linea...');
		dbms_output.put_line('.     exec p_empate_respuesta;');
	else
		dbms_output.put_line(chr(13));
		dbms_output.put_line('.     Aun no se definido la partida activa');
	end if;
end;
/
