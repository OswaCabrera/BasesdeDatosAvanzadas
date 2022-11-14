--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 02/09/2022
--@Descripción: Creacion del usuario oswaldo0104



--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.

whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system1 as sysdba

declare
  v_count number;
  v_username varchar2(20) := 'OSWALDO0401';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count = 0 then
    execute immediate 'create user '||v_username|| ' identified by oswaldo quota unlimited on users';
    execute immediate 'grant create session, create table to '||v_username|| ;
  end if;
end;
/

Prompt creando al usuario oswaldo0104
create user oswaldo0104 identified by oswaldo quota unlimited on users;
grant create session, create table to oswaldo0104;

create table oswaldo0104.t01_db_version as
select product,version,version_full
from product_component_version;
