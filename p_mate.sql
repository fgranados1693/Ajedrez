/*
Procedimiento para finalizar partida aceptando un jaque mate
*/
SET SERVEROUTPUT ON
create or replace procedure p_mate
	is
	partida partida_activa.id_partida%type;
	ult_mov movimientos.movimiento%type;
	anotacion movimientos.notacion%type;
	ajuste movimientos.notacion%type;
	apodo1 jugadores.nickname%type;
	apodo2 jugadores.nickname%type;
	result partidas.resultado%type;
begin
	partida := f_partida_activa;
	if partida <> -1 then
		ult_mov := f_n_mov;
		if ult_mov > 0 then
			begin
				-- se carta la notacion inicial de la taba movimientos
				select notacion
				into anotacion
				from movimientos
				where id_partida = partida and movimiento = ult_mov; 
			end;
			-- se define el ajuste para la notacion de jaque mate
			ajuste := substr (anotacion,length(anotacion),length(anotacion));
			if ajuste <> '+' then
				ajuste := '++';
			end if;
			-- se realiza el update en la tabla movimiento
			update movimientos
			set notacion = to_char(anotacion||ajuste)
			where id_partida = partida and movimiento = ult_mov;
			-- se elimina la partida activa
			delete partida_activa;
			-- informacion de los jugadores
			select nickname1, nickname2
			into apodo1, apodo2
			from partidas
			where id_partida = partida;
			-- se define el color del jugador ganador
			if mod(ult_mov,2) = 0 then
				result := 'gana '||apodo1||' con las fichas negras por jaque mate';
			else
				result := 'gana '||apodo1||' con las fichas blancas por jaque mate';
			end if;
			-- agrega el resultado en la tabla partida
			update partidas
			set resultado = result
			where id_partida = partida;
			-- agrega la fecha de finalizacion
			update partidas
			set fecha_fin = sysdate
			where id_partida = partida;
			dbms_output.put_line(chr(13));
			dbms_output.put_line(result);
			commit;
		else
			dbms_output.put_line(chr(13));
			dbms_output.put_line('.   Aun no hay movimientos...');
		end if;
	else
		dbms_output.put_line(chr(13));
		dbms_output.put_line('.   Aun no hay partidas activas...');
	end if;
exception
	when OTHERS then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Error '||SQLCODE|| ' detalle '||SQLERRM);
		rollback;
end;
/
