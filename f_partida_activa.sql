/*
función retorna el id_partida de la tabla partida_activa.
*/
create or replace function f_partida_activa
return number is
	partida partida_activa.id_partida%type;
begin
	begin
		select id_partida
		into partida
		from partida_activa;
	exception
		when NO_DATA_FOUND then
			partida := -1;
	end;
	return partida;
end;
/