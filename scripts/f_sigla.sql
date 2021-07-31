/*
función que recibe un parametro, el id_ficha, y retorna la sigla de la misma.
Si el parametro ingresado no es correcto retorna alguno de los siguientes numeros {-1, -2} segun corresponda.
*/
create or replace function f_sigla (idFicha number)
return char is
	letra fichas.sigla%type;
begin
	begin
		select
			sigla
		into letra
		from fichas
		where id_ficha = idFicha;
	exception
		when NO_DATA_FOUND then
			-- coordenada invalida
			letra := 'x';
		when VALUE_ERROR then
			-- Excede el numero de caracteres permitidos
			letra := 'y';
		when OTHERS then
			letra := 'z';
	end;
	return letra;
end;
/