/*
Trigger para actualizar el estado de la partida en el tablero.
*/
CREATE or replace trigger t_mov
  AFTER 
  insert ON movimientos
  BEGIN
	declare
		partida partidas.id_partida%type;
		ficha fichas.id_ficha%type;
		inicial movimientos.pos_inicial%type;
		final movimientos.pos_inicial%type;
		id fichas.id_ficha%type;
	begin
		-- se cargan los punteros con la información del último movimiento
		select id_partida, id_ficha, pos_inicial, pos_final
		into partida, ficha, inicial, final
		from movimientos
		where id_movimiento = (select max(id_movimiento) from movimientos);
		-- se realiza la actualización del movimiento
		update estado_partidas
		set id_ficha = null
		where id_cord_tab = inicial and id_partida = partida;
		update estado_partidas
		set id_ficha = ficha
		where id_cord_tab = final and id_partida = partida;
	end;
  END;
/