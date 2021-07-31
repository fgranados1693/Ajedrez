/*
función que retorna 1 si el movimiento es válido. Recibe dos parametros, la coordenada de la posición actual y la coordenada de la posición final Si el movimiento no es válido retorna 0.
*/
create or replace function f_peon_val (coordenada1 number, coordenada2 number, mueven varchar2)
return number is
	validar number;
	movimiento number(1) := -2;
	f number(1);
	partida partida_activa.id_partida%type;
	idficha fichas.id_ficha%type;
	type rango is varray(8) of integer;
	recorrido rango;
begin
	if mueven = 'Blancas' then
		f := 6;
	else
		f := 0;
	end if;
	-- se carga la partida activa
	partida := f_partida_activa;
	if partida > 0 then
		-- valida que el movimiento sea válido
		if coordenada2 - coordenada1 in (16, -16) then
			-- se valida si el movimiento es vertical
			case 
				when coordenada1 in (1, 9, 17, 25, 33, 41, 49, 57) then recorrido := rango(1, 9, 17, 25, 33, 41, 49, 57);
				when coordenada1 in (2, 10, 18, 26, 34, 42, 50, 58) then recorrido := rango(2, 10, 18, 26, 34, 42, 50, 58);
				when coordenada1 in (3, 11, 19, 27, 35, 43, 51, 59) then recorrido := rango(3, 11, 19, 27, 35, 43, 51, 59);
				when coordenada1 in (4, 12, 20, 28, 36, 44, 52, 60) then recorrido := rango(4, 12, 20, 28, 36, 44, 52, 60);
				when coordenada1 in (5, 13, 21, 29, 37, 45, 53, 61) then recorrido := rango(5, 13, 21, 29, 37, 45, 53, 61);
				when coordenada1 in (6, 14, 22, 30, 38, 46, 54, 62) then recorrido := rango(6, 14, 22, 30, 38, 46, 54, 62);
				when coordenada1 in (7, 15, 23, 31, 39, 47, 55, 63) then recorrido := rango(7, 15, 23, 31, 39, 47, 55, 63);
				when coordenada1 in (8, 16, 24, 32, 40, 48, 56, 64) then recorrido := rango(8, 16, 24, 32, 40, 48, 56, 64);
			end case;
			-- se define el tipo de movimiento
			for i in 1..8 loop
				if recorrido(i) = coordenada2 and coordenada1 > coordenada2 then
					-- el movimiento es hacia abajo
					movimiento := 2;
					validar := -1; -- se inicializa el no permitido
					exit;
				elsif recorrido(i) = coordenada2 and coordenada1 < coordenada2 then
					-- el movimiento es hacia arriba
					movimiento := 1;
					validar := -1; -- se inicializa el no permitido
					exit;
				end if;
			end loop;
			-- se validan los movimientos
			if movimiento = 1 and coordenada1 between 9 and 16 and mueven = 'Blancas' then
				validar := 1;
				for j in 3..4  loop
					select coalesce(sum(id_ficha),70)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = recorrido(j);
					if idFicha between 1 and 12 then
						validar := -1;
						exit;
					end if;
				end loop;
			elsif movimiento = 2 and coordenada1 between 49 and 56 and mueven = 'Negras' then
				validar := 1;
				for j in reverse 5..7  loop
					select coalesce(sum(id_ficha),70)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = recorrido(j);
					if idFicha between 1 and 12 then
						validar := 1;
						exit;
					end if;
				end loop;
			end if;
		elsif (coordenada2 - coordenada1 = 8 and mueven = 'Blancas') or (coordenada2 - coordenada1 = -8 and mueven = 'Negras') then
			-- validar que en la coordenada 2 este vacía
			select coalesce(id_ficha,0)
			into idficha
			from estado_partidas
			where id_partida = partida and id_cord_tab = coordenada2;
			if idficha = 0 then
				validar := 1;
			else
				validar := -1; -- se ubica una pieza propia
			end if;
		elsif (coordenada2 - coordenada1 in (7, 9) and mueven = 'Blancas') or (coordenada2 - coordenada1 in (-7, -9) and mueven = 'Negras') then
			-- validar que en la coordenada 2 haya una pieza oponente
			select coalesce(sum(id_ficha),0)
			into idficha
			from estado_partidas
			where id_partida = partida and id_cord_tab = coordenada2 and id_ficha between (1 + f) and (6 + f);
			if idficha > 0 then
				validar := 1;
			else
				validar := -1; -- inválido, no hay oponente
			end if;
		else
			validar := -2; -- movimiento inválido;
		end if;
	else
		validar := -3; -- no existe una partida activa
	end if;
	return validar;
end;
/
