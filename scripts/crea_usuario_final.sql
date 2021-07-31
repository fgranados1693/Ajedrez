/*
Se crea el usuario de producción
*/

alter session set "_oracle_script"=true;

create user chess
identified by "123";

grant connect, resource to chess;

alter user chess
quota unlimited on users;