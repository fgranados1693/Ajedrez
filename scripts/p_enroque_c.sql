/*
procedimiento que realiza un enroque corto del jugador activo.
*/
SET SERVEROUTPUT ON
create or replace procedure p_enroque_c
	is
	mueven varchar2(9);
	partida partida_activa.id_partida%type;
	nFichas number(2);
	mFichas number(2);
	f number(1);
	g number(1);
	rey coordenadas_tablero.id_cord_tab%type;
	rey_op coordenadas_tablero.id_cord_tab%type;
	jaque number(1);
	jaque_op number(1);
	anotacion movimientos.notacion%type;
	prox_mov movimientos.movimiento%type;
begin
	-- se verifica que existe partida activa
	partida := f_partida_activa;
	if partida > 0 then
		-- se verifica quien mueve para ajustar el id_ficha
		mueven := f_mueve;
		if mueven = 'Blancas' then
			f := 0;
			g := 0;
		else
			f := 56;
			g := 6;
		end if;
		-- se verifica que entre el rey y la torre no existan fichas
		select count(id_ficha)
		into nFichas
		from estado_partidas
		where id_partida = partida and id_cord_tab in (6 + f, 7 + f);
		-- se verifica que se ubique el rey y la torre en su posicion inicial
		select count(id_ficha)
		into mFichas
		from estado_partidas
		where id_partida = partida and id_cord_tab in (5 + f, 8 + f) and id_ficha in (1 + g, 4 + g);
		if nFichas = 0 and mFichas = 2 then
			-- se hace el update para el enroque corto
			anotacion := '0-0'; 
			prox_mov := f_n_mov + 1;
			insert into movimientos (movimiento, id_partida, id_ficha, pos_inicial, pos_final, notacion) values (prox_mov,partida,(1 + g),(5 + f),(7 + f),anotacion);
			dbms_output.put_line('movimiento, id_partida, id_ficha, pos_inicial, pos_final, notacion '||prox_mov||' '||partida||' '||(1 + g)||' '||(5 + f)||' '||(7 + f)||' '||anotacion);
			--insert into movimientos (movimiento, id_partida, id_ficha, pos_inicial, pos_final, notacion) values (9,362,1,5,7,'0-0');
			-- update de la torre en tabla estado_partidas
			update estado_partidas
			set id_ficha = null 
			where id_cord_tab = (8 + f) and id_partida = partida;
			--update estado_partidas
  			--set id_ficha = null where id_cord_tab = 8 and id_partida = 362;
			dbms_output.put_line('1 id_cord_tab  id_partida '||(8 + f)||' '||partida);
			update estado_partidas
			set id_ficha = (4 + g) 
			where id_cord_tab = (6 + f) and id_partida = partida;
			-- update estado_partidas
  			-- set id_ficha = 4 where id_cord_tab = 6 and id_partida = 362;
			dbms_output.put_line('2 id_cord_tab  id_partida '||(6 + f)||' '||partida);
			rey := f_rey;
			dbms_output.put_line('rey '||rey);
			rey_op := f_rey_op;
			dbms_output.put_line('rey_op '||rey_op);
			jaque_op := f_jaque_op(rey_op);
			jaque := f_jaque(rey);
			dbms_output.put_line('jaque rey '||jaque);
			dbms_output.put_line('jaque_op rey_op '||jaque_op);
			if jaque = 0 then
				if jaque_op = 1 then
					update movimientos
					set notacion = anotacion || '+'
					where movimiento = prox_mov and id_partida = partida;
				end if;
				dbms_output.put_line('realiza commit');
				commit;
			else
				dbms_output.put_line(chr(13));
				dbms_output.put_line('movimiento invalido, deja al rey en jaque...');
				dbms_output.put_line('realiza rollback');
				rollback;
			end if;
		else
			dbms_output.put_line(chr(13));
			dbms_output.put_line('Movimiento invalido, el enroque corto no se puede realizar...');
		end if;
	else
		dbms_output.put_line(chr(13));
		dbms_output.put_line('.Aun no existe partida activa...');
	end if;
end;
/
start viewTablero