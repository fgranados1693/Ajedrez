/*
función retorna el color de ficha que le toca mover
*/
create or replace function f_mueve
return varchar2 is
	mueven varchar2(9);
begin
	declare
		movimiento movimientos.id_movimiento%type;
		partida partida_activa.id_partida%type;
	begin
		partida := f_partida_activa;
		if partida < 0 then
			mueven := 'NoExPar'; -- no existe partida
		else
			movimiento := f_n_mov;
			if movimiento < 0 then
				mueven := 'NoExPar'; -- no existe partida
			else
				if (mod(movimiento,2) = 0) then
					mueven := 'Blancas';
				else
					mueven := 'Negras';
				end if;
			end if;
		end if;
	end;
	return mueven;
end;
/