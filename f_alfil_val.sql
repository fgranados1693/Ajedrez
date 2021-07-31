/*
función que retorna 1 si el movimiento es válido. Recibe dos parametros, la coordenada de la posición actual y la coordenada de la posición final Si el movimiento no es válido retorna 0.
*/
SET SERVEROUTPUT ON
create or replace function f_alfil_val (coordenada1 number, coordenada2 number, mueven varchar2)
return number is
	validar number := -2;
	movimiento number(1) := -2;
	f number(1);
	i number(2);
	k number(2) := 1;
	partida partida_activa.id_partida%type;
	idFicha fichas.id_ficha%type;
	type rango is varray(8) of integer;
	recorrido rango;
begin
	if mueven = 'Blancas' then
		f := 0;
	else
		f := 6;
	end if;
	-- se carga la partida activa
	partida := f_partida_activa;
	if partida > 0 then
		-- se valida si el movimiento es diagonal con pendiente negativa
		case 
			when coordenada1 in (56, 63) then recorrido := rango(56, 63, 0, 0, 0, 0, 0, 0);
			when coordenada1 in (48, 55, 62) then recorrido := rango(48, 55, 62, 0, 0, 0, 0, 0);
			when coordenada1 in (40, 47, 54, 61) then recorrido := rango(40, 47, 54, 61, 0, 0, 0, 0);
			when coordenada1 in (32, 39, 46, 53, 60) then recorrido := rango(32, 39, 46, 53, 60, 0, 0, 0);
			when coordenada1 in (24, 31, 38, 45, 52, 59) then recorrido := rango(24, 31, 38, 45, 52, 59, 0, 0);
			when coordenada1 in (16, 23, 30, 37, 44, 51, 58) then recorrido := rango(16, 23, 30, 37, 44, 51, 58, 0);
			when coordenada1 in (8, 15, 22, 29, 36, 43, 50, 57) then recorrido := rango(8, 15, 22, 29, 36, 43, 50, 57);
			when coordenada1 in (7, 14, 21, 28, 35, 42, 49) then recorrido := rango(7, 14, 21, 28, 35, 42, 49, 0);
			when coordenada1 in (6, 13, 20, 27, 34, 41) then recorrido := rango(6, 13, 20, 27, 34, 41, 0, 0);
			when coordenada1 in (5, 12, 19, 26, 33) then recorrido := rango(5, 12, 19, 26, 33, 0, 0, 0);
			when coordenada1 in (4, 11, 18, 25) then recorrido := rango(4, 11, 18, 25, 0, 0, 0, 0);
			when coordenada1 in (3, 10, 17) then recorrido := rango(3, 10, 17, 0, 0, 0, 0, 0);
			when coordenada1 in (2, 9) then recorrido := rango(2, 9, 0, 0, 0, 0, 0, 0);
			when coordenada1 in (1, 64) then recorrido := rango(100, 100, 100, 100, 100, 100, 100, 100);
		end case;
		-- se define el tipo de movimiento
		if recorrido(1) <> 100 then
			for i in 1..8 loop
				if recorrido(i) = coordenada2 and coordenada1 > coordenada2 then
					-- el movimiento es hacia la derecha
					movimiento := 1;
					validar := -1; -- se inicializa el no permitido
					exit;
				elsif recorrido(i) = coordenada2 and coordenada1 < coordenada2 then
					-- el movimiento es hacia la izquierda
					movimiento := 2;
					validar := -1; -- se inicializa el no permitido
					exit;
				end if;
			end loop;
		end if;
		-- se valida si el movimiento es diagonal con pendiente positiva
		if movimiento not in (1, 2) then
			case 
				when coordenada1 in (49, 58) then recorrido := rango(49, 58, 0, 0, 0, 0, 0, 0);
				when coordenada1 in (41, 50, 59) then recorrido := rango(41, 50, 59, 0, 0, 0, 0, 0);
				when coordenada1 in (33, 42, 51, 60) then recorrido := rango(33, 42, 51, 60, 0, 0, 0, 0);
				when coordenada1 in (25, 34, 43, 52, 61) then recorrido := rango(25, 34, 43, 52, 61, 0, 0, 0);
				when coordenada1 in (17, 26, 35, 44, 53, 62) then recorrido := rango(17, 26, 35, 44, 53, 62, 0, 0);
				when coordenada1 in (9, 18, 27, 36, 45, 54, 63) then recorrido := rango(9, 18, 27, 36, 45, 54, 63, 0);
				when coordenada1 in (1, 10, 19, 28, 37, 46, 55, 64) then recorrido := rango(1, 10, 19, 28, 37, 46, 55, 64);
				when coordenada1 in (2, 11, 20, 29, 38, 47, 56) then recorrido := rango(2, 11, 20, 29, 38, 47, 56, 0);
				when coordenada1 in (3, 12, 21, 30, 39, 48) then recorrido := rango(3, 12, 21, 30, 39, 48, 0, 0);
				when coordenada1 in (4, 13, 22, 31, 40) then recorrido := rango(4, 13, 22, 31, 40, 0, 0, 0);
				when coordenada1 in (5, 14, 23, 32) then recorrido := rango(5, 14, 23, 32, 0, 0, 0, 0);
				when coordenada1 in (6, 15, 24) then recorrido := rango(6, 15, 24, 0, 0, 0, 0, 0);
				when coordenada1 in (7, 16) then recorrido := rango(7, 16, 0, 0, 0, 0, 0, 0);
				when coordenada1 in (8, 57) then recorrido := rango(100, 0, 0, 0, 0, 0, 0, 0);
			end case;
			-- se define el tipo de movimiento
			if recorrido(1) <> 100 then
				for i in 1..8 loop
					if recorrido(i) = coordenada2 and coordenada1 < coordenada2 then
						-- el movimiento es hacia la derecha
						movimiento := 2; -- creciente
						validar := -1; -- se inicializa el no permitido
						exit;
					elsif recorrido(i) = coordenada2 and coordenada1 > coordenada2 then
						-- el movimiento es hacia la izquierda
						movimiento := 1; -- reversa
						validar := -1; -- se inicializa el no permitido
						exit;
					end if;
				end loop;
			end if;
		end if;
		-- se validan los movimientos
		if movimiento = 1 then
			for j in reverse 1..8  loop
				if recorrido(j) < coordenada1 and recorrido(j) <> 0 then
					select coalesce(sum(id_ficha),70)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = recorrido(j);
					if recorrido(j) = coordenada2 and idFicha not in (1 + f, 2 + f, 3 + f, 4 + f, 5 + f, 6 + f) then
						validar := 1;
						exit;
					elsif (idFicha between 1 and 12 and recorrido(j) > coordenada2) or (recorrido(j) <= coordenada2) then
						exit;
					end if;
				end if;
			end loop;
		elsif movimiento = 2 then
			for j in 1..8  loop
					if recorrido(j) > coordenada1  then
						select coalesce(sum(id_ficha),70)
						into idficha
						from estado_partidas
						where id_partida = partida and id_cord_tab = recorrido(j);
						if recorrido(j) = coordenada2 and idFicha not in (1 + f, 2 + f, 3 + f, 4 + f, 5 + f, 6 + f) then
							validar := 1;
							exit;
						elsif (idFicha between 1 and 12 and recorrido(j) < coordenada2) or (recorrido(j) >= coordenada2) then
							exit;
						end if;
					end if;
				end loop;
		end if;
	else
		validar := -3; -- no existe una partida activa
	end if;
	return validar;
end;
/
