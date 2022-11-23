--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 25/09/2022
--@Descripción: Creacion del usuario oswaldo0401

--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.
disconnect 

whenever sqlerror exit rollback;

connect sys@ocpbda2_pooled/system2 as sysdba

insert into oswaldo0501.t01_session_data 
  (id, sid, logon_time, username, status, server, osuser, machine, type, process, port)
  select 4 id, sid, logon_time, username, status, server, osuser, machine, type, process, port from v$session
  where username='SYS' and type='USER';

create table oswaldo0501.t07_foreground_process as (
  select p.sosid, p.pname, s.osuser as os_username, s.schemaname as bd_username,  s.username, s.server, p.pga_max_mem/1024/1024 as pga_max_mem_mb,
  p.tracefile, p.background
  from v$process p left join v$session s
  on p.addr = s.paddr
  where p.background is null
);

create table oswaldo0501.t08_f_process_actual as (
  select p.sosid, p.pname, s.osuser as os_username, s.schemaname as bd_username,  s.username, s.server, p.pga_max_mem/1024/1024 as pga_max_mem_mb,
  p.tracefile, p.background
  from v$process p left join v$session s
  on p.addr = s.paddr
  where sys_context('USERENV','SID') = s.sid
);

create table oswaldo0501.t09_background_process as (
  select p.sosid, p.pname, s.osuser as os_username, s.schemaname as bd_username, s.username, s.server, p.pga_max_mem/1024/1024 as pga_max_mem_mb,
  p.tracefile, p.background
  from v$process p left join v$session s
  on p.addr = s.paddr
  where p.background is not null
);

commit;