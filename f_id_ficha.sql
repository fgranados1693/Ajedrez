/*
función que recibe un parametro, la coordenada del tablero, y retorna el id_ficha de la tabla fichas.
Si los parametros ingresados no son correctos retorna alguno de los siguientes numeros {-1, -2, -3} segun corresponda.
*/
set verify OFF
create or replace function f_id_ficha (pcoord number)
return number is
	idFicha fichas.id_ficha%type;
begin
	declare
		nPartida partida_activa.id_partida%type;
		mueven varchar2(9);
	begin
		-- se determina la partida activa
		nPartida := f_partida_activa;
		if nPartida < 0 then
			idFicha := -1;
		else
			mueven := f_mueve;
			if mueven = 'Blancas' then
				select
				id_ficha
				into idFicha
				from estado_partidas
				where id_cord_tab = pcoord and id_partida = nPartida and id_ficha between 1 and 6;
			elsif mueven = 'Negras' then
				select
				id_ficha
				into idFicha
				from estado_partidas
				where id_cord_tab = pcoord and id_partida = nPartida and id_ficha between 7 and 12;
			else
				idFicha := -2;
			end if;
		end if;	
	exception
		when NO_DATA_FOUND then
			-- coordenada invalida
			idFicha := -3;
		when VALUE_ERROR then
			-- Excede el numero de caracteres permitidos
			idFicha := -4;
		when OTHERS then
			idFicha := SQLCODE;
	end;
	return idFicha;
end;
/