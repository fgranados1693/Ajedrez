/*
función retorna el nombre completo del jugador 1 o 2 de la tabla partida_activa.
*/
create or replace function f_full_name (njugador number)
return varchar2 is
	jugador varchar2(47);
begin
	declare
		num_partida partidas.id_partida%type;
	begin
		-- se carga el numero de partida activa
		num_partida := f_partida_activa;
		if num_partida < 0 then
			jugador := 'NoExPar'; -- no existe partida
		else
			if njugador = 1 then
				-- se carga el nombre del jugador 1 de partida activa
				select
				(b.nombre||' '||b.apellido1||' '||b.apellido2)
				into jugador
				from partidas a
				join jugadores b on b.nickname = a.nickname1
				where a.id_partida = num_partida;
			else
				-- se carga el nombre del jugador 2 de partida activa
				select
				(b.nombre||' '||b.apellido1||' '||b.apellido2)
				into jugador
				from partidas a
				join jugadores b on b.nickname = a.nickname2
				where a.id_partida = num_partida;
			end if;
		end if;
		
	end;
	return jugador;
end;
/