/*
función que recibe tres parametro, el id_ficha, y retorna el nombre de la misma.
Si el parametro ingresado no es correcto retorna alguno de los siguientes numeros {-1, -2} segun corresponda.
*/
create or replace function f_validar (coordenada1 number, coordenada2 number, idFicha1 number, mueven varchar2)
return number is
	validar number;
begin
		case 
			when idFicha1 in (1,7) then validar := f_rey_val(coordenada1, coordenada2, mueven);
			when idFicha1 in (2,8) then validar := f_dama_val(coordenada1, coordenada2, mueven);
			when idFicha1 in (3,9) then validar := f_alfil_val(coordenada1, coordenada2, mueven);
			when idFicha1 in (4,10) then validar := f_torre_val(coordenada1, coordenada2, mueven);
			when idFicha1 in (5,11) then validar := f_caballo_val(coordenada1, coordenada2, mueven);
			when idFicha1 in (6,12) then validar := f_peon_val(coordenada1, coordenada2, mueven);
			else validar := -2; -- valor invalido
		end case;
	return validar;
end;
/