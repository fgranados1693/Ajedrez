/*
Menu inicial del juego
*/
SET SERVEROUTPUT ON
set verify OFF
declare
	nickname01 jugadores.nickname%type;
	nickname02 jugadores.nickname%type;
	nickname_blancas jugadores.nickname%type;
	partida partidas.id_partida%type;
	jugador1 varchar2(47);
	jugador2 varchar2(47);
	registro1 number;
	registro2 number;
	dumi varchar2(100);
	numMov movimientos.id_movimiento%type;
	mueven varchar2(9);
	num number;
begin
	nickname01 := upper('&Nombre_jugador1');
	nickname02 := upper('&Nombre_jugador2');
	dumi := '&partida';
	registro1 := f_existe_nickname (nickname01);
	registro2 := f_existe_nickname (nickname02);
	partida := coalesce(cast(dumi as number),-999);
	if partida = -999 then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Numero de partida invalido...');
	elsif registro1 <> 1 then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Jugador1 no existe...');
	elsif registro2 <> 1 then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Jugador2 no existe...');
	else
		jugador1 := f_full_name_otro(nickname01);
		jugador2 := f_full_name_otro(nickname02);
		-- se determina si representan una partida real
		select 1 into num
		from partidas where id_partida = partida and ((nickname1 = nickname01 and nickname2 = nickname02) or (nickname1 = nickname02 and nickname2 = nickname01));
		-- se determina el ultimo movimiento
		select coalesce(max(a.id_partida),0)
		into numMov
		from movimientos a
		join partidas b on a.id_partida = b.id_partida
		where a.id_partida = partida and ((b.nickname1 = nickname01 and b.nickname2 = nickname02) or (b.nickname1 = nickname02 and b.nickname2 = nickname01));
		-- se determina las piezas que mueven
		if mod(numMov,2) = 0 then
			mueven := 'Negras';
		else
			mueven := 'Blancas';
		end if;
		-- se determina el jugador con las piezas blancas
		select nickname1
		into nickname_blancas
		from partidas
		where id_partida = partida;
		-- impresion de resultados
		dbms_output.put_line(chr(13));
		dbms_output.put_line('datos de la partida...');
		if nickname_blancas = nickname01 then
			dbms_output.put_line('Blancas: '||jugador1);
			dbms_output.put_line('Negras: '||jugador2);
		else
			dbms_output.put_line('Blancas: '||jugador2);
			dbms_output.put_line('Negras: '||jugador1);
		end if;
		dbms_output.put_line('Siguiente movimiento: '||mueven);
		-- se elimina el registro existente y se carga un nuevo registro con la partida vigente
		delete partida_activa;
		insert into partida_activa (id_partida) values (partida);
		commit;
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
