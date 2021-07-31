/*
Ingreso de partidas
*/
SET SERVEROUTPUT ON
set verify OFF
column partida format a9;
column jugador1 format a47;
column jugador2 format a47;
set pages 160
set linesize 400
DECLARE
	apodo1 jugadores.nickname%type;
	apodo2 jugadores.nickname%type;
	partida partidas.id_partida%type;
	null_value exception;
	pragma exception_init(null_value, -1400);
	jugadorNoExiste   exception;
	pragma exception_init(jugadorNoExiste  , -02291);
	largo_texto exception;
	pragma exception_init(largo_texto, -6502);
	--jugardor_no_existe exception;
	--pragma exception_init(convertion_error, -2291);
BEGIN
	apodo1 := upper('&nickname1');
	apodo2 := upper('&nickname2');
	/*
	TODO: Mejorar verificando si existe para que el id sea continuo
	*/
	-- se inserta el nickname de ambos jugadores
	insert into partidas (nickname1, nickname2) values (apodo1,apodo2);
	-- se carga el id de la partida creada
	select
		max(id_partida)
	into partida
	from partidas;
	-- se agrega el texto de salida
	dbms_output.put_line(chr(13));
	dbms_output.put_line('La inforamcion se ha cargado satisfactoriamente, y se muestra a continuacion...');
	dbms_output.put_line(chr(13));
	dbms_output.put_line('N Partida   Jugador 1                                         Jugador 2                                      ');
	dbms_output.put_line('_________   _______________________________________________   _______________________________________________');
	declare
		cursor c_partida is
		select
			(select (nombre||' '||apellido1||' '||apellido2) 
			from jugadores where nickname = apodo1) as jugador1,
			(select (nombre||' '||apellido1||' '||apellido2) 
			from jugadores where nickname = apodo2) as jugador2,
			fecha_inicio
		from partidas
		where id_partida = partida;
	begin
		for part in c_partida loop
			dbms_output.put_line(rpad(partida,12,' ')||rpad(part.jugador1,50,' ')||rpad(part.jugador2,50,' '));
		end loop;
	end;
EXCEPTION
	when null_value then
		dbms_output.put_line(chr(13));
		DBMS_OUTPUT.PUT_LINE('Debe ingresar el nickname de cada jugador, igual como se ingreso al crearlo ');
	when jugadorNoExiste   then
		dbms_output.put_line(chr(13));
		DBMS_OUTPUT.PUT_LINE('Uno o ambos jugadores no han sido creados');
	when largo_texto then
		dbms_output.put_line(chr(13));
		DBMS_OUTPUT.PUT_LINE('El texto que intenta ingresar es muy largo, por favor ingrese uno mas corto.');
	when others then
		dbms_output.put_line(chr(13));
		DBMS_OUTPUT.PUT_LINE('Error de Oracle: '||SQLCODE||' detalle: '||SQLERRM );
END; 
/