/*
función retorna el nombre completo del jugador, si existe.
*/
create or replace function f_full_name_otro (vnick VARCHAR2)
return varchar2 is
	jugador varchar2(47);
	nickname1 jugadores.nickname%type;
	registro number;
begin
	nickname1 := upper(vnick);
	registro := f_existe_nickname (nickname1);
	if registro = 1 then
		select (nombre||' '||apellido1||' '||apellido2)
		into jugador
		from jugadores
		where nickname = nickname1;
	else
		jugador := 'NoExJug';
	end if;
	return jugador;
end;
/