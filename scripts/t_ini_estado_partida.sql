CREATE or replace trigger t_ini_estado_partida
  AFTER 
  insert ON partidas
  BEGIN
	declare
		id partidas.id_partida%type;
	begin
		-- se busca el ultimo id_partida insertado
		select max(id_partida)
		into id
		from partidas;
		-- se inicializa la tabla estado_partidas
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (1, id, 4);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (2, id, 5);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (3, id, 3);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (4, id, 2);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (5, id, 1);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (6, id, 3);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (7, id, 5);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (8, id, 4);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (9, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (10, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (11, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (12, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (13, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (14, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (15, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (16, id, 6);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (17, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (18, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (19, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (20, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (21, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (22, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (23, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (24, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (25, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (26, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (27, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (28, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (29, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (30, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (31, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (32, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (33, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (34, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (35, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (36, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (37, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (38, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (39, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (40, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (41, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (42, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (43, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (44, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (45, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (46, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (47, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (48, id, null);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (49, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (50, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (51, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (52, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (53, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (54, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (55, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (56, id, 12);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (57, id, 10);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (58, id, 11);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (59, id, 9);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (60, id, 8);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (61, id, 7);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (62, id, 9);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (63, id, 11);
		insert into estado_partidas (id_cord_tab, id_partida, id_ficha) values (64, id, 10);
	end;
  END;
/

