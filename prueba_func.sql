
set serveroutput on
set verify OFF
declare
	partida_vigente partidas.id_partida%type;
begin
	select id_partida
	into partida_vigente
	from partida_activa;
	dbms_output.put_line('update');
exception
		when NO_DATA_FOUND then
			-- coordenada invalida
			dbms_output.put_line('insert');
end;
/