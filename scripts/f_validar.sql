/*
función que recibe tres parametro, el id_ficha, y retorna el nombre de la misma.
Si el parametro ingresado no es correcto retorna alguno de los siguientes numeros {-1, -2} segun corresponda.
*/
create or replace function f_validar (coordenada1 number, coordenada2 number, idFicha1 number, mueven varchar2)
return number is
	validar number;
begin
		--case idFicha1
			--when 1 then validar := f_rey(coordenada1, coordenada2, mueven);
			--when 2 then validar := f_dama(coordenada1, coordenada2, mueven);
			--when 3 then validar := f_alfil(coordenada1, coordenada2, mueven);
			--when 4 then validar := f_torre(coordenada1, coordenada2, mueven);
			--when 5 then validar := f_caballo(coordenada1, coordenada2, mueven);
			--when 6 then validar := f_peon(coordenada1, coordenada2, mueven);
			--else validar := -2; -- valor invalido
		--end case;
		validar := 1;
	return validar;
end;
/