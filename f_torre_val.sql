/*
función que retorna 1 si el movimiento es válido. Recibe dos parametros, la coordenada de la posición actual y la coordenada de la posición final Si el movimiento no es válido retorna 0.
*/
SET SERVEROUTPUT ON
create or replace function f_torre_val (coordenada1 number, coordenada2 number, mueven varchar2)
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
		-- vectores de recorridos horizontales
		case 
			when coordenada1 between 1 and 8 then recorrido := rango(1, 2, 3, 4, 5, 6, 7, 8);
			when coordenada1 between 9 and 16 then recorrido := rango(9, 10, 11, 12, 13, 14, 15, 16);
			when coordenada1 between 17 and 24 then recorrido := rango(17, 18, 19, 20, 21, 22, 23, 24);
			when coordenada1 between 25 and 32 then recorrido := rango(25, 26, 27, 28, 29, 30, 31, 32);
			when coordenada1 between 33 and 40 then recorrido := rango(33, 34, 35, 36, 37, 38, 39, 40);
			when coordenada1 between 41 and 48 then recorrido := rango(41, 42, 43, 44, 45, 46, 47, 48);
			when coordenada1 between 49 and 56 then recorrido := rango(49, 50, 51, 52, 53, 54, 55, 56);
			when coordenada1 between 57 and 64 then recorrido := rango(57, 58, 59, 60, 61, 62, 63, 64);
		end case;
		-- se valida y define el tipo de movimiento horizontal
		for i in 1..8 loop
			if recorrido(i) = coordenada2 and coordenada1 < coordenada2 then
				-- el movimiento es hacia la derecha
				movimiento := 1;
				validar := -1; -- se inicializa el no permitido
				exit;
			elsif recorrido(i) = coordenada2 and coordenada1 > coordenada2 then
				-- el movimiento es hacia la izquierda
				movimiento := 2;
				validar := -1; -- se inicializa el no permitido	
			end if;
		end loop;
		if movimiento not in (1,2) then
			-- vectores de recorridos vertical
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
		end if;
		-- se validan los movimientos
		if movimiento = 1 then
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
		elsif movimiento = 2 then
			for j in reverse 1..8  loop
				if recorrido(j) < coordenada1 then
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
		end if;
	else
		validar := -3; -- no existe una partida activa
	end if;
	return validar;
end;
/
