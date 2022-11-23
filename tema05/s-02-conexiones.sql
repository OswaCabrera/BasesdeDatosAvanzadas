--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 25/09/2022
--@Descripción: Creacion del usuario oswaldo0401

--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.

whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys en modo dedicated
connect sys/system2 as sysdba

alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

create table oswaldo0501.t01_session_data as (
  select 1 id, sid, logon_time, username, status, server, osuser, machine, type, process, port from v$session
  where username='SYS' and type='USER'
);

commit;

disconnect

connect sys@ocpbda2_dedicated/system2 as sysdba

insert into oswaldo0501.t01_session_data 
  (id, sid, logon_time, username, status, server, osuser, machine, type, process, port)
  select 2 id, sid, logon_time, username, status, server, osuser, machine, type, process, port from v$session
  where username='SYS' and type='USER';

commit;

connect sys@ocpbda2_shared/system2 as sysdba

insert into oswaldo0501.t01_session_data 
  (id, sid, logon_time, username, status, server, osuser, machine, type, process, port)
  select 3 id, sid, logon_time, username, status, server, osuser, machine, type, process, port from v$session
  where username='SYS' and type='USER';

commit;


