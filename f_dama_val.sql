/*
función que retorna 1 si el movimiento es válido. Recibe dos parametros, la coordenada de la posición actual y la coordenada de la posición final Si el movimiento no es válido retorna 0.
*/
create or replace function f_dama_val (coordenada1 number, coordenada2 number, mueven varchar2)
return number is
	validar number;
begin
	validar := f_alfil_val(coordenada1 , coordenada2, mueven);
	if validar = -2 then
		validar := f_torre_val(coordenada1 , coordenada2, mueven);
	end if;
	return validar;
end;
/
