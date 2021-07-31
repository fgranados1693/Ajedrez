/*
Ingreso de movimientos, recibe como parámetro las coordenas (la de la posición inicial o de la pieza que va a mover, y la de posición que quedará la pieza)
*/
SET SERVEROUTPUT ON
set verify OFF
declare
	pcoord1 coordenadas_tablero.coordenada%type;
	pcoord2 coordenadas_tablero.coordenada%type;
	coordenada1 coordenadas_tablero.id_cord_tab%type;
	coordenada2 coordenadas_tablero.id_cord_tab%type;
	letra1 fichas.sigla%type;
	letra2 fichas.sigla%type;
	captura varchar(2);
	mueven varchar2(9);
	idFicha1 fichas.id_ficha%type;
	idFicha2 fichas.id_ficha%type;
	partida partida_activa.id_partida%type;
	validar number(2);
	nombreFichaIni fichas.nombre%type;
	nombreFichaFin fichas.nombre%type;
	anotacion movimientos.notacion%type;
	prox_mov movimientos.movimiento%type;
	rey coordenadas_tablero.id_cord_tab%type;
	rey_op coordenadas_tablero.id_cord_tab%type;
	jaque number(1);
	jaque_op number(1);
begin
	pcoord1 := lower('&coordenada1');
	pcoord2 := lower('&coordenada2');
	coordenada1 := f_coord (pcoord1);
	coordenada2 := f_coord (pcoord2);
	partida := f_partida_activa;
	if partida < 0 then
			dbms_output.put_line(chr(13));
			dbms_output.put_line('Aun no se ha creado una partida');
	else
		if coordenada1 < 0 or coordenada2 < 0 then
			dbms_output.put_line(chr(13));
			dbms_output.put_line('coordenada invalida 1');
		else
			idFicha1 := f_id_ficha (coordenada1);
			if idFicha1 < 0 then
				dbms_output.put_line(chr(13));
				dbms_output.put_line('Movimiento invalido');
			else
				-- se carga el id_ficha de la posicion final
				select id_ficha
				into idFicha2
				from estado_partidas
				where id_partida = partida and id_cord_tab = coordenada2;
				-- se carga el color de la ficha que mueve
				mueven := f_mueve;
				-- se carga el nombre de la ficha que va a mover
				nombreFichaIni := f_nombre_ficha(idFicha1);
				-- se carga la letra de la pieza que ataca
				letra1 := f_sigla(idFicha1);
				-- se carga la letra de la pieza del contrincante, si existe captura
				letra2 := f_sigla(idFicha2);
				nombreFichaFin := f_nombre_ficha(idFicha2);
				-- se define la notacion de la captura
				if letra2 not in ('x', 'y', 'z') then
					captura := 'x'||letra2;
				else
					captura := '';
				end if;
				if mueven = 'Blancas' and idFicha2 in (1,2,3,4,5,6) then
					dbms_output.put_line(chr(13));
					dbms_output.put_line('La coordenada '||pcoord2||' contiene la ficha '||nombreFichaFin||' ficha blanca');
				elsif mueven = 'Negras' and idFicha2 in (7,8,9,10,11,12) then
					dbms_output.put_line(chr(13));
					dbms_output.put_line('La coordenada '||pcoord1||' contiene la ficha '||nombreFichaFin||' ficha negra');
				else
					validar := f_validar(coordenada1, coordenada2, idFicha1, mueven);
					if validar = -2 then
						dbms_output.put_line(chr(13));
						dbms_output.put_line('El movimiento que intenta hacer de la pieza '||nombreFichaIni||' no es permitido');
					elsif validar = -1 then
						dbms_output.put_line(chr(13));
						dbms_output.put_line('El movimiento que intenta hacer de la pieza '||nombreFichaIni||' es invalido');
					else
						-- se agrega la notacion del movimiento
						anotacion := letra1||pcoord1||pcoord2||captura;
						-- se carga la siguiente partida
						prox_mov := f_n_mov + 1;
						-- Se realizan la insercion del movimiento en las tabla movimientos
						mueven := f_mueve;
						insert into movimientos (movimiento, id_partida, id_ficha, pos_inicial, pos_final, notacion) values (prox_mov,partida,idFicha1,coordenada1,coordenada2,anotacion);
						-- verificando si hay coronacion
						if mod(prox_mov,2) <> 0 and idFicha1 = 6 and coordenada2 in (57, 58, 59, 60, 61, 62, 63, 64) then	
							-- cambiar la pieza en estado partidas
							update estado_partidas
							set id_ficha = 2
							where id_partida = partida and id_cord_tab = coordenada2;
							-- último movimiento de blancas
							update movimientos
							set notacion = notacion ||'=D'
							where movimiento = prox_mov and id_partida = partida;
						elsif mod(prox_mov,2) = 0 and idFicha1 = 12 and coordenada2 in (1, 2, 3, 4, 5, 6, 7, 8) then
							-- cambiar la pieza en estado partidas
							update estado_partidas
							set id_ficha = 8
							where id_partida = partida and id_cord_tab = coordenada2;
							-- último movimiento de negras
							update movimientos
							set notacion = notacion ||'=d'
							where movimiento = prox_mov and id_partida = partida;
						end if;
						mueven := f_mueve;
						rey := f_rey(1);
						rey_op := f_rey(2);
						jaque_op := f_jaque(rey_op, 2);
						jaque := f_jaque(rey, 1);
						if jaque_op = 0 then
							if jaque = 1 then
								update movimientos
								set notacion = notacion || '+'
							  	where movimiento = prox_mov and id_partida = partida;
								dbms_output.put_line(chr(13));
							  	dbms_output.put_line('Jaque al rey de las piezas '||mueven);
							end if;
							commit;
						else
							dbms_output.put_line(chr(13));
							dbms_output.put_line('movimiento invalido, deja al rey en jaque...');
							--dbms_output.put_line('realiza rollback');
							rollback;
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
exception
	when NO_DATA_FOUND then
		-- coordenada invalida
		dbms_output.put_line(chr(13));
		dbms_output.put_line('coordenada invalida 3');
		rollback;
		--coordenada := -1;
	when VALUE_ERROR then
		-- Excede el numero de caracteres permitidos
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Excede el numero de caracteres permitidos');
		rollback;
		--coordenada := -2;
	when OTHERS then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Error '||SQLCODE|| ' detalle '||SQLERRM);
		rollback;
		--coordenada := SQLCODE;
end;
/
start viewTablero
