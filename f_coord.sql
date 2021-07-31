/*
función que recibe un parametro, la coordenada del tablero, y retorna el id_ficha de la tabla coordenas_tablero.
Si el parametro ingresado no es correcto retorna alguno de los siguientes numeros {-1, -2, -3} segun corresponda.
*/
create or replace function f_coord (pcoord char)
return number is
	coordenada coordenadas_tablero.id_cord_tab%type;
begin
	begin
		select
			id_cord_tab
		into coordenada
		from coordenadas_tablero
		where coordenada = pcoord;
	exception
		when NO_DATA_FOUND then
			-- coordenada invalida
			coordenada := -1;
		when VALUE_ERROR then
			-- Excede el numero de caracteres permitidos
			coordenada := -2;
		when OTHERS then
			coordenada := SQLCODE;
	end;
	return coordenada;
end;
/