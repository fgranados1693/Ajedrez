/*
función que recibe dos parametros, la coordenada del tablero y el numero de partida, y retorna el id_ficha de la tabla coordenas_tablero.
Si los parametros ingresados no son correctos retorna alguno de los siguientes numeros {-1, -2, -3} segun corresponda.
*/
set verify OFF
create or replace function f_id_ficha (pcoord number, nPartida number)
return number is
	idFicha fichas.id_ficha%type;
begin
	begin
		select
			id_ficha
		into idFicha
		from estado_partidas
		where id_cord_tab = pcoord and id_partida = nPartida;
	exception
		when NO_DATA_FOUND then
			-- coordenada invalida
			idFicha := -1;
		when VALUE_ERROR then
			-- Excede el numero de caracteres permitidos
			idFicha := -2;
		when OTHERS then
			idFicha := -3;
	end;
	return idFicha;
end;
/