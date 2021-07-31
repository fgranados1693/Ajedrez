/*
función que recibe un parametro, el nickname, y retorna true si existe en la tabla jugadores, o false caso contrario.
*/
create or replace function f_existe_nickname (vnick VARCHAR2)
return number is
	res number := 0;
begin
	declare
		cant number;
	begin
		select
			count(0)
		into cant
		from jugadores
		where nickname = vnick;
		if cant = 1 then
			res := 1;
		end if;
	end;
	return res;
end;
/