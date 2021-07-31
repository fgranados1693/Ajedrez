/*
función que recibe dos parametro, la coordenada del tablero y si es el rey blanco o negro, y retorna su estado con relación al jaque.
si está en jaque retorna 1, si no retorna 0 y si no existe partida activa retorna -1.
*/
create or replace function f_jaque (coordenada number, n number)
return number is
	mueven varchar2(9);
	jaque number(1);
	i number(2);
	f number(1);
	lim number(3);
	idficha fichas.id_ficha%type;
	partida partida_activa.id_partida%type;
	type rango is varray(8) of integer;
	recorrido rango;
begin
	mueven := f_mueve;
	recorrido := rango(17, 10, -6, -15, -17, -10, 6, 15);
	if n = 1 then
		if mueven = 'Blancas' then
			f := 6;
		else
			f := 0;
		end if;
	else
		if mueven = 'Blancas' then
			f := 0;
		else
			f := 6;
		end if;
	end if;
	
	-- se carga la partida activa
	partida := f_partida_activa;
	if partida > 0 then
		-- se valida el norte (n)
		i := coordenada + 8;
		jaque := 0;
		while i < 65 loop
			select coalesce(sum(id_ficha),0)
			into idficha
			from estado_partidas
			where id_partida = partida and id_cord_tab = i;
			if idficha > 0 then
				-- se busca la primera ficha que esté en esta dirección
				if idficha in (2 + f, 4 + f) then
					jaque := 1;
				end if;
				i := 66; -- para salir del ciclo
			end if;
			i := i + 8;
		end loop;
		if jaque = 0 then
			-- se valida el sur (s)
			i := coordenada - 8;
			while i > 0 loop
				select coalesce(sum(id_ficha),0)
				into idficha
				from estado_partidas
				where id_partida = partida and id_cord_tab = i;
				if idficha > 0 then
					-- se busca la primera ficha que esté en esta dirección
					if idficha in (2 + f, 4 + f) then
						jaque := 1;
					end if;
					i := 0; -- para salir del ciclo
				end if;
				i := i - 8;
			end loop;
			-- se valida el este
			if jaque = 0 then
				i := coordenada + 1;
				case 
					when coordenada between 1 and 8 then lim := 8;
					when coordenada between 9 and 16 then lim := 16;
					when coordenada between 17 and 24 then lim := 24;
					when coordenada between 25 and 32 then lim := 32;
					when coordenada between 33 and 40 then lim := 40;
					when coordenada between 41 and 48 then lim := 48;
					when coordenada between 49 and 56 then lim := 56;
					when coordenada between 57 and 64 then lim := 64;
				end case;
				while i <= lim loop
					select coalesce(sum(id_ficha),0)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = i;
					if idficha > 0 then
						-- se busca la primera ficha que esté en esta dirección
						if idficha in (2 + f, 4 + f) then
							jaque := 1;
						end if;
						i := lim + 1; -- para salir del ciclo
					end if;
					i := i + 1;
				end loop;
			end if;
			-- se valida el oeste
			if jaque = 0 then
				i := coordenada - 1;
				case 
					when coordenada between 1 and 8 then lim := 1;
					when coordenada between 9 and 16 then lim := 9;
					when coordenada between 17 and 24 then lim := 17;
					when coordenada between 25 and 32 then lim := 25;
					when coordenada between 33 and 40 then lim := 33;
					when coordenada between 41 and 48 then lim := 41;
					when coordenada between 49 and 56 then lim := 49;
					when coordenada between 57 and 64 then lim := 57;
				end case;
				while i >= lim loop
					select coalesce(sum(id_ficha),0)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = i;
					if idficha > 0 then
						-- se busca la primera ficha que esté en esta dirección
						if idficha in (2 + f, 4 + f) then
							jaque := 1;
						end if;
						i := lim - 1; -- para salir del ciclo
					end if;
					i := i - 1;
				end loop;
			end if;
			-- se valida el noreste
			if jaque = 0 then
				i := coordenada + 9;
				case 
					when coordenada in (49, 58) then lim := 58;
					when coordenada in (41, 50, 59) then lim := 59;
					when coordenada in (33, 42, 51, 60) then lim := 60;
					when coordenada in (25, 34, 43, 52, 61) then lim := 61;
					when coordenada in (17, 26, 35, 44, 53, 62) then lim := 62;
					when coordenada in (9, 18, 27, 36, 45, 54, 63) then lim := 63;
					when coordenada in (1, 10, 19, 28, 37, 46, 55, 64) then lim := 64;
					when coordenada in (2, 11, 20, 29, 38, 47, 56) then lim := 56;
					when coordenada in (3, 12, 21, 30, 39, 48) then lim := 48;
					when coordenada in (4, 13, 22, 31, 40) then lim := 40;
					when coordenada in (5, 14, 23, 32) then lim := 32;
					when coordenada in (6, 15, 24) then lim := 24;
					when coordenada in (7, 16) then lim := 16;
					when coordenada in (8, 57) then lim := 0;
				end case;
				while i <= lim loop
					select coalesce(sum(id_ficha),0)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = i;
					if idficha > 0 then
						-- se busca la primera ficha que esté en esta dirección
						if idficha in (1 + f, 2 + f, 3 + f, 6 + f) and i = (coordenada + 9) then
							jaque := 1;
						elsif idficha in (2 + f, 3 + f) and i > (coordenada + 9) then
							jaque := 1;
						end if;
						i := lim + 1; -- para salir del ciclo
					end if;
					i := i + 9;
				end loop;
			end if;
			-- se valida el suroeste
			if jaque = 0 then
				i := coordenada - 9;
				case 
					when coordenada in (49, 58) then lim := 49;
					when coordenada in (41, 50, 59) then lim := 41;
					when coordenada in (33, 42, 51, 60) then lim := 33;
					when coordenada in (25, 34, 43, 52, 61) then lim := 25;
					when coordenada in (17, 26, 35, 44, 53, 62) then lim := 17;
					when coordenada in (9, 18, 27, 36, 45, 54, 63) then lim := 9;
					when coordenada in (1, 10, 19, 28, 37, 46, 55, 64) then lim := 1;
					when coordenada in (2, 11, 20, 29, 38, 47, 56) then lim := 2;
					when coordenada in (3, 12, 21, 30, 39, 48) then lim := 3;
					when coordenada in (4, 13, 22, 31, 40) then lim := 4;
					when coordenada in (5, 14, 23, 32) then lim := 5;
					when coordenada in (6, 15, 24) then lim := 6;
					when coordenada in (7, 16) then lim := 7;
					when coordenada in (8, 57) then lim := 100;
				end case;
				while i >= lim loop
					select coalesce(sum(id_ficha),0)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = i;
					if idficha > 0 then
						-- se busca la primera ficha que esté en esta dirección
						if idficha in (1 + f, 2 + f, 3 + f, 6 + f) and i = (coordenada - 9) then
							jaque := 1;
						elsif idficha in (2 + f, 3 + f) and i < (coordenada - 9) then
							jaque := 1;
						end if;
						i := lim; -- para salir del ciclo
					end if;
					i := i - 9;
				end loop;
			end if;
			-- se valida el noroeste
			if jaque = 0 then
				i := coordenada + 7;
				case 
					when coordenada in (56, 63) then lim := 63;
					when coordenada in (48, 55, 62) then lim := 62;
					when coordenada in (40, 47, 54, 61) then lim := 61;
					when coordenada in (32, 39, 46, 53, 60) then lim := 60;
					when coordenada in (24, 31, 38, 45, 52, 59) then lim := 59;
					when coordenada in (16, 23, 30, 37, 44, 51, 58) then lim := 58;
					when coordenada in (8, 15, 22, 29, 36, 43, 50, 57) then lim := 57;
					when coordenada in (7, 14, 21, 28, 35, 42, 49) then lim := 49;
					when coordenada in (6, 13, 20, 27, 34, 41) then lim := 41;
					when coordenada in (5, 12, 19, 26, 33) then lim := 33;
					when coordenada in (4, 11, 18, 25) then lim := 25;
					when coordenada in (3, 10, 17) then lim := 17;
					when coordenada in (2, 9) then lim := 9;
					when coordenada in (1, 64) then lim := 0;
				end case;
				while i <= lim loop
					select coalesce(sum(id_ficha),0)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = i;
					if idficha > 0 then
						-- se busca la primera ficha que esté en esta dirección
						if idficha in (1 + f, 2 + f, 3 + f, 6 + f) and i = (coordenada + 7) then
							jaque := 1;
						elsif idficha in (2 + f, 3 + f) and i > (coordenada + 7) then
							jaque := 1;
						end if;
						i := lim; -- para salir del ciclo
					end if;
					i := i + 7;
				end loop;
			end if;
			-- se valida el sureste
			if jaque = 0 then
				i := coordenada - 7;
				case 
					when coordenada in (56, 63) then lim := 56;
					when coordenada in (48, 55, 62) then lim := 48;
					when coordenada in (40, 47, 54, 61) then lim := 40;
					when coordenada in (32, 39, 46, 53, 60) then lim := 32;
					when coordenada in (24, 31, 38, 45, 52, 59) then lim := 24;
					when coordenada in (16, 23, 30, 37, 44, 51, 58) then lim := 16;
					when coordenada in (8, 15, 22, 29, 36, 43, 50, 57) then lim := 8;
					when coordenada in (7, 14, 21, 28, 35, 42, 49) then lim := 7;
					when coordenada in (6, 13, 20, 27, 34, 41) then lim := 6;
					when coordenada in (5, 12, 19, 26, 33) then lim := 5;
					when coordenada in (4, 11, 18, 25) then lim := 4;
					when coordenada in (3, 10, 17) then lim := 3;
					when coordenada in (2, 9) then lim := 2;
					when coordenada in (1, 64) then lim := 100;
				end case;
				while i >= lim loop
					select coalesce(sum(id_ficha),0)
					into idficha
					from estado_partidas
					where id_partida = partida and id_cord_tab = i;
					if idficha > 0 then
						-- se busca la primera ficha que esté en esta dirección
						if idficha in (1 + f, 2 + f, 3 + f, 6 + f) and i = (coordenada - 7) then
							jaque := 1;
						elsif idficha in (2 + f, 3 + f) and i < (coordenada - 7) then
							jaque := 1;
						end if;
						i := lim; -- para salir del ciclo
					end if;
					i := i - 7;
				end loop;
			end if;
			-- se valida caballo
			if jaque = 0 then
				for j in 1..8 loop
					i := coordenada + recorrido(j);
					if i > 0 and i < 65 then
						select coalesce(sum(id_ficha),0)
						into idficha
						from estado_partidas
						where id_partida = partida and id_cord_tab = i;
						if idficha > 0 then
							-- se busca la primera ficha que esté en esta dirección
							if idficha = (5 + f) then
								jaque := 1;
								exit;
							end if;
						end if;
					end if;
				end loop;
			end if;	
		end if;
	else
		jaque := -1; -- no existe una partida activa
	end if;
	return jaque;
end;
/