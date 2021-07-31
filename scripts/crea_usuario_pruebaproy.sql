/*
Se crea el usuario para las pruebas del proyecto
*/

alter session set "_oracle_script"=true;

create user pruebaproy
identified by "ajedrez";

grant connect, resource to pruebaproy;

alter user pruebaproy
quota unlimited on users;