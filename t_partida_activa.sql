/*
Trigger para actualizar el estado de la partida en el tablero.
*/
CREATE or replace trigger t_partida_activa
  AFTER 
  insert ON partidas
  BEGIN
	declare
		partida partidas.id_partida%type;
		partida_vigente partidas.id_partida%type;
	begin
		-- se cargan el puntero con el id de la partida recien creada
		select coalesce(max(id_partida),0)
		into partida
		from partidas;
		-- se carga el puntero del id de la partida vigente
		select id_partida
		into partida_vigente
		from partida_activa;
		-- se elimina el registro existente y se carga un nuevo registro con la partida vigente
		delete partida_activa;
		insert into partida_activa (id_partida) values (partida);
	exception
		when NO_DATA_FOUND then
			-- se realiza la actualización del movimiento
			insert into partida_activa values (partida);
	end;
  END;
/

