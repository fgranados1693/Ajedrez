/*
Procedimiento que permite solicitar al jugador oponente el empate
*/
create or replace procedure p_empate_respuesta
 is
	partida partida_activa.id_partida%type;
	last_mov movimientos.movimiento%type;
	anotacion movimientos.notacion%type;
begin
	partida := f_partida_activa;
	if partida > 0 then
		last_mov := f_n_mov;
		if last_mov > 0 then
			-- se carga la notación anterior
			select notacion
			into anotacion
			from movimientos where id_partida = partida and movimiento = last_mov;
			-- se actualiza la notación en la tabla movimientos
			update movimientos
			set notacion = anotacion || '='
			where movimiento = last_mov and id_partida = partida;
			-- agrega el resultado en la tabla partida
			update partidas
			set resultado = 'partida finalizada con empate en el movimiento '||to_char(last_mov)
			where id_partida = partida;
			-- agrega la fecha de finalizacion
			update partidas
			set fecha_fin = sysdate
			where id_partida = partida;
			-- se elimina la partida activa
			delete partida_activa;
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.     La partida ha finalizado con empate en el movimiento '||to_char(last_mov));
			commit; 
		else
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.     Aun no se ha hecho ninguna movida');
		end if;
	else
		dbms_output.put_line(chr(13));
		dbms_output.put_line('.     Aun no se definido la partida activa');
	end if;
end;
/
