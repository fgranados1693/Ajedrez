/*
función que recibe un parametro, el id_ficha, y retorna el nombre de la misma.
Si el parametro ingresado no es correcto retorna alguno de los siguientes numeros {-1, -2} segun corresponda.
*/
create or replace function f_nombre_ficha (idFicha number)
return varchar is
	nombreFicha fichas.nombre%type;
begin
	begin
		select
			nombre
		into nombreFicha
		from fichas
		where id_ficha = idFicha;
	exception
		when NO_DATA_FOUND then
			-- coordenada invalida
			nombreFicha := 'ci';
		when VALUE_ERROR then
			-- Excede el numero de caracteres permitidos
			nombreFicha := 'ne';
		when OTHERS then
			nombreFicha := to_char(SQLCODE);
	end;
	return nombreFicha;
end;
/