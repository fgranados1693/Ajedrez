/*
función que retorna 1 si el movimiento es válido. Recibe dos parametros, la coordenada de la posición actual y la coordenada de la posición final Si el movimiento no es válido retorna 0.
*/
create or replace function f_caballo_val (coordenada1 number, coordenada2 number, mueven varchar2)
return number is
	validar number;
	f number(1);
	partida partida_activa.id_partida%type;
	idficha fichas.id_ficha%type;
begin
	if mueven = 'Blancas' then
		f := 0;
	else
		f := 6;
	end if;
	-- se carga la partida activa
	partida := f_partida_activa;
	if partida > 0 then
		-- valida que el movimiento sea válido
		if coordenada2 - coordenada1 in (17, 10, -6, -15, -17, -10, 6, 15) then
			-- validar que no exista en la coordenada 2 una pieza propia
			select coalesce(sum(id_ficha),0)
			into idficha
			from estado_partidas
			where id_partida = partida and id_cord_tab = coordenada2 and id_ficha between (1 + f) and (6 + f);
			if idficha = 0 then
				validar := 1;
			else
				validar := -1; -- se ubica una pieza propia
			end if;
		else
			validar := -2; -- Movimiento inválido
		end if;
	else
		validar := -3; -- no existe una partida activa
	end if;
	return validar;
end;
/
