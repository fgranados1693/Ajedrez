/*
procedimiento que realiza un enroque largo del jugador activo.
*/
SET SERVEROUTPUT ON
create or replace procedure p_enroque_l
	is
--declare
	mueven varchar2(9);
	partida partidas.id_partida%type;
	nFichas number(3);
	mFichas number(3);
	f coordenadas_tablero.id_cord_tab%type;
	g fichas.id_ficha%type;
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
		where id_partida = partida and id_cord_tab in (2 + f, 3 + f, 4 + f);
		-- se verifica que se ubique el rey y la torre en su posicion inicial
		select count(id_ficha)
		into mFichas
		from estado_partidas
		where id_partida = partida and id_cord_tab in (1 + f, 5 + f) and id_ficha in (1 + g, 4 + g);
		if nFichas = 0 and mFichas = 2 then
			-- se hace el update para el enroque corto
			anotacion := '0-0-0'; 
			prox_mov := f_n_mov + 1;
			insert into movimientos (movimiento, id_partida, id_ficha, pos_inicial, pos_final, notacion) values (prox_mov,partida,(1 + g),(5 + f),(3 + f),anotacion);
			-- update de la torre en tabla estado_partidas
			update estado_partidas
			set id_ficha = null
			where id_cord_tab = (1 + f) and id_partida = partida;
			--update estado_partidas
			update estado_partidas
			set id_ficha = (4 + g) 
			where id_cord_tab = (4 + f) and id_partida = partida;
			-- update estado_partidas
			rey := f_rey(1);
			rey_op := f_rey(2);
			jaque_op := f_jaque(rey, 1);
			jaque := f_jaque(rey_op, 2);
			if jaque = 0 then
				if jaque_op = 1 then
					update movimientos
					set notacion = anotacion || '+'
					where movimiento = prox_mov and id_partida = partida;
				end if;
				commit;
			else
				dbms_output.put_line(chr(13));
				dbms_output.put_line('movimiento invalido, deja al rey en jaque...');
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