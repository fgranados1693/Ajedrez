
set lines 50
set pages 100
set linesize 100
set serveroutput on
--set verify OFF
declare
	-- declaracion de variables del tablaro
	a1 fichas.sigla%type := '';
	b1 fichas.sigla%type := '';
	c1 fichas.sigla%type := '';
	d1 fichas.sigla%type := '';
	e1 fichas.sigla%type := '';
	f1 fichas.sigla%type := '';
	g1 fichas.sigla%type := '';
	h1 fichas.sigla%type := '';
	a2 fichas.sigla%type := '';
	b2 fichas.sigla%type := '';
	c2 fichas.sigla%type := '';
	d2 fichas.sigla%type := '';
	e2 fichas.sigla%type := '';
	f2 fichas.sigla%type := '';
	g2 fichas.sigla%type := '';
	h2 fichas.sigla%type := '';
	a3 fichas.sigla%type := '';
	b3 fichas.sigla%type := '';
	c3 fichas.sigla%type := '';
	d3 fichas.sigla%type := '';
	e3 fichas.sigla%type := '';
	f3 fichas.sigla%type := '';
	g3 fichas.sigla%type := '';
	h3 fichas.sigla%type := '';
	a4 fichas.sigla%type := '';
	b4 fichas.sigla%type := '';
	c4 fichas.sigla%type := '';
	d4 fichas.sigla%type := '';
	e4 fichas.sigla%type := '';
	f4 fichas.sigla%type := '';
	g4 fichas.sigla%type := '';
	h4 fichas.sigla%type := '';
	a5 fichas.sigla%type := '';
	b5 fichas.sigla%type := '';
	c5 fichas.sigla%type := '';
	d5 fichas.sigla%type := '';
	e5 fichas.sigla%type := '';
	f5 fichas.sigla%type := '';
	g5 fichas.sigla%type := '';
	h5 fichas.sigla%type := '';
	a6 fichas.sigla%type := '';
	b6 fichas.sigla%type := '';
	c6 fichas.sigla%type := '';
	d6 fichas.sigla%type := '';
	e6 fichas.sigla%type := '';
	f6 fichas.sigla%type := '';
	g6 fichas.sigla%type := '';
	h6 fichas.sigla%type := '';
	a7 fichas.sigla%type := '';
	b7 fichas.sigla%type := '';
	c7 fichas.sigla%type := '';
	d7 fichas.sigla%type := '';
	e7 fichas.sigla%type := '';
	f7 fichas.sigla%type := '';
	g7 fichas.sigla%type := '';
	h7 fichas.sigla%type := '';
	a8 fichas.sigla%type := '';
	b8 fichas.sigla%type := '';
	c8 fichas.sigla%type := '';
	d8 fichas.sigla%type := '';
	e8 fichas.sigla%type := '';
	f8 fichas.sigla%type := '';
	g8 fichas.sigla%type := '';
	h8 fichas.sigla%type := '';
	-- declaracion de otras variables
	num_partida partidas.id_partida%type;
	jugador1 varchar2(47);
	jugador2 varchar2(47);
	movimiento movimientos.id_movimiento%type;
	mueven varchar2(7);
	dumi varchar2(100);
	i number := 0;
	-- declaracion de las excepciones
	null_value exception;
	pragma exception_init(null_value, -6550);
begin
	-- se carga el numero de partida
	select id_partida
	into num_partida
	from partida_activa;
	-- se carga el nombre del jugador 1
	select
		(b.nombre||' '||b.apellido1||' '||b.apellido2)
	into jugador1
	from partidas a
	join jugadores b on b.nickname = a.nickname1
	where a.id_partida = num_partida;
	-- se carga el nombre del jugador 
	select
		(b.nombre||' '||b.apellido1||' '||b.apellido2)
	into jugador2
	from partidas a
	join jugadores b on b.nickname = a.nickname2
	where a.id_partida = num_partida;
	-- quien mueve
	select count(0)
	into movimiento
	from movimientos;
	if (mod(movimiento,2) = 0) then
		mueven := 'Blancas';
	else
		mueven := 'Negras';
	end if;
	-- se carga la partida
	declare
		-- creacion del cursor
		cursor c_coord_tab is
		select 
			d.fila,
			d.col,
			d.coordenada,
			a.sigla
		from fichas a
		join estado_partidas b on b.id_ficha = a.id_ficha
		join coordenadas_tablero d on d.id_cord_tab = b.id_cord_tab
		where b.id_partida = num_partida
		order by d.fila, d.col;
	begin
		for cc in c_coord_tab loop
		if length(cc.coordenada) > 0 then i := i + 1;
		end if;
		case cc.coordenada
			when 'a1' then a1 := cc.sigla;
			when 'b1' then b1 := cc.sigla;
			when 'c1' then c1 := cc.sigla;
			when 'd1' then d1 := cc.sigla;
			when 'e1' then e1 := cc.sigla;
			when 'f1' then f1 := cc.sigla;
			when 'g1' then g1 := cc.sigla;
			when 'h1' then h1 := cc.sigla;
			when 'a2' then a2 := cc.sigla;
			when 'b2' then b2 := cc.sigla;
			when 'c2' then c2 := cc.sigla;
			when 'd2' then d2 := cc.sigla;
			when 'e2' then e2 := cc.sigla;
			when 'f2' then f2 := cc.sigla;
			when 'g2' then g2 := cc.sigla;
			when 'h2' then h2 := cc.sigla;
			when 'a3' then a3 := cc.sigla;
			when 'b3' then b3 := cc.sigla;
			when 'c3' then c3 := cc.sigla;
			when 'd3' then d3 := cc.sigla;
			when 'e3' then e3 := cc.sigla;
			when 'f3' then f3 := cc.sigla;
			when 'g3' then g3 := cc.sigla;
			when 'h3' then h3 := cc.sigla;
			when 'a4' then a4 := cc.sigla;
			when 'b4' then b4 := cc.sigla;
			when 'c4' then c4 := cc.sigla;
			when 'd4' then d4 := cc.sigla;
			when 'e4' then e4 := cc.sigla;
			when 'f4' then f4 := cc.sigla;
			when 'g4' then g4 := cc.sigla;
			when 'h4' then h4 := cc.sigla;
			when 'a5' then a5 := cc.sigla;
			when 'b5' then b5 := cc.sigla;
			when 'c5' then c5 := cc.sigla;
			when 'd5' then d5 := cc.sigla;
			when 'e5' then e5 := cc.sigla;
			when 'f5' then f5 := cc.sigla;
			when 'g5' then g5 := cc.sigla;
			when 'h5' then h5 := cc.sigla;
			when 'a6' then a6 := cc.sigla;
			when 'b6' then b6 := cc.sigla;
			when 'c6' then c6 := cc.sigla;
			when 'd6' then d6 := cc.sigla;
			when 'e6' then e6 := cc.sigla;
			when 'f6' then f6 := cc.sigla;
			when 'g6' then g6 := cc.sigla;
			when 'h6' then h6 := cc.sigla;
			when 'a7' then a7 := cc.sigla;
			when 'b7' then b7 := cc.sigla;
			when 'c7' then c7 := cc.sigla;
			when 'd7' then d7 := cc.sigla;
			when 'e7' then e7 := cc.sigla;
			when 'f7' then f7 := cc.sigla;
			when 'g7' then g7 := cc.sigla;
			when 'h7' then h7 := cc.sigla;
			when 'a8' then a8 := cc.sigla;
			when 'b8' then b8 := cc.sigla;
			when 'c8' then c8 := cc.sigla;
			when 'd8' then d8 := cc.sigla;
			when 'e8' then e8 := cc.sigla;
			when 'f8' then f8 := cc.sigla;
			when 'g8' then g8 := cc.sigla;
			when 'h8' then h8 := cc.sigla;
		end case;
	end loop;
	end;
	-- imprimir resultados
	dbms_output.put_line(chr(13));
	if i > 1 then
		dbms_output.put_line('.  Partida Numero: '||num_partida);
		dbms_output.put_line(rpad('.  Blancas: '||jugador1, 42, ' ')||lpad('Negras: '||jugador2, 42, ' '));
		dbms_output.put_line(rpad('.  Movimientos realizados: '||movimiento, 42, ' ')||lpad('Mueven: '||mueven, 42, ' '));
		dbms_output.put_line(chr(13));
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('8  |    '||a8||'    |    '||b8||'    |    '||c8||'    |    '||d8||'    |    '||e8||'    |    '||f8||'    |    '||g8||'    |    '||h8||'    |');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('7  |    '||a7||'    |    '||b7||'    |    '||c7||'    |    '||d7||'    |    '||e7||'    |    '||f7||'    |    '||g7||'    |    '||h7||'    |');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('6  |    '||a6||'    |    '||b6|| '    |    '||c6|| '    |    '||d6|| '    |    '||e6|| '    |    '||f6|| '    |    '||g6|| '    |    '||h6|| '    |    ');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('5  |    '||a5||'    |    '||b5|| '    |    '||c5|| '    |    '||d5|| '    |    '||e5|| '    |    '||f5|| '    |    '||g5|| '    |    '||h5|| '    |    ');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('4  |    '||a4|| '    |    '||b4|| '    |    '||c4|| '    |    '||d4|| '    |    '||e4|| '    |    '||f4|| '    |    '||g4|| '    |    '||h4|| '    |    ');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('3  |    '||a3|| '    |    '||b3|| '    |    '||c3|| '    |    '||d3|| '    |    '||e3|| '    |    '||f3|| '    |    '||g3|| '    |    '||h3|| '    |    ');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('2  |    '||a2|| '    |    '||b2|| '    |    '||c2|| '    |    '||d2|| '    |    '||e2|| '    |    '||f2|| '    |    '||g2|| '    |    '||h2|| '    |    ');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line('1  |    '||a1|| '    |    '||b1|| '    |    '||c1|| '    |    '||d1|| '    |    '||e1|| '    |    '||f1|| '    |    '||g1|| '    |    '||h1|| '    |    ');
		dbms_output.put_line('.  |         |         |         |         |         |         |         |         |');
		dbms_output.put_line(rpad('.  -',84,'-'));
		dbms_output.put_line('.       A         B         C         D         E         F         F         H');
	else
		dbms_output.put_line('La partida ingresada no existe');
	end if;
exception
	when others then
		dbms_output.put_line(chr(13));
		dbms_output.put_line('Debe ingresar un numero...'||SQLCODE||' detalle: '||SQLERRM);
end;
/