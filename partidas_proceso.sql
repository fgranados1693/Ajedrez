/*
Menu inicial del juego
*/
SET SERVEROUTPUT ON
set verify OFF
declare
	nickname01 jugadores.nickname%type;
	jugador1 varchar2(47);
	registro1 number;
begin
	nickname01 := upper('&Nombre_jugador');
	dbms_output.put_line('nickname01 '||nickname01);
	registro1 := f_existe_nickname (nickname01);
	if registro1 <> 1 then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Jugador1 no existe...');
	else
		jugador1 := f_full_name_otro(nickname01);
		declare
			cursor c_partidas is
			select 
			id_partida, nickname1, nickname2,fecha_inicio
			from partidas
			where resultado is null and (nickname1 = nickname01 or nickname2 = nickname01);
		begin
			dbms_output.put_line(chr(13));
			dbms_output.put_line('  El detalle de partidas en las que participa el jugador '||jugador1||' son:');
			dbms_output.put_line('partida   jugador Blancas   jugador negras   fecha inicio');
			for part in c_partidas loop
				dbms_output.put_line(lpad(part.id_partida, 7, '.')||lpad(part.nickname1,18,' ')||lpad(part.nickname2,17,' ')||lpad(to_char(part.fecha_inicio),15,' '));
			end loop;
		end;
	end if;
exception
	when VALUE_ERROR then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Excede el numero de caracteres permitidos');
	when NO_DATA_FOUND then
			dbms_output.put_line(chr(13));
			dbms_output.put_line('Partida ingresada no existe');
	when others then
		dbms_output.put_line(chr(13));
		DBMS_OUTPUT.PUT_LINE('Error de Oracle: '||SQLCODE||' detalle: '||SQLERRM );
end;
/
