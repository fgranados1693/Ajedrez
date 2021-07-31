/*
función retorna el numero de movimientos que lleva la partida
*/
create or replace function f_n_mov
return number is
	nMov number;
begin
	declare
		partida partida_activa.id_partida%type;
	begin
		partida := f_partida_activa;
		if partida < 0 then
			nMov := -1; -- no existe partida
		else
			select coalesce(max(movimiento),0)
			into nMov
			from movimientos
			where id_partida = partida;
		end if;
	end;
	return nMov;
end;
/