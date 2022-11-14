--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 15/1072022
--@Descripción: Creacion del usuario oswaldo0401

--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.

whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

declare
  v_count number;
  v_username varchar2(20) := 'OSWALDO0404';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count = 0 then
    execute immediate 'create user '||v_username|| ' identified by oswaldo quota unlimited on users';
    
  end if;
end;
/

grant create session, create table, create sequence, create procedure to oswaldo0404;

commit;