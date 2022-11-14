--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 02/09/2022
--@Descripción: Script para generar al usuario oswaldo0105 y oswaldo0106

--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.
whenever sqlerror exit rollback;
-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.
Prompt conectando como usuario sys
connect sys/Hola1234# as sysdba

declare
  v_count number;
  v_count2 number;
  v_username1 varchar2(20) := 'OSWALDO0105';
  v_username2 varchar2(20) := 'OSWALDO0106';

begin

  select count(*) into v_count from all_users where username=v_username1;

  if v_count >0 then
    execute immediate 'drop user '||v_username1|| 'cascade';
  end if;

  select count(*) into v_count2 from all_users where username=v_username2;

  if v_count2 >0 then
    execute immediate 'drop user '||v_username2|| 'cascade';
  end if;


end;
/

Prompt creando al usuario oswaldo0105

create user oswaldo0105 identified by oswaldo;
grant create session to oswaldo0105;

Prompt creando al usuario oswaldo0106

create user oswaldo0106 identified by oswaldo;
grant create session to oswaldo0106;

grant sysdba to oswaldo0104;
grant sysoper to oswaldo0105;
grant sysbackup to oswaldo0106;
