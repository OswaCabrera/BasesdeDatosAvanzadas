--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 25/09/2022
--@Descripción: Creacion del usuario oswaldo0401

--esta instrucción permite detener la ejecución del script al primer error
--útil para detectar errores de forma rápida.
--al final del script se debe invocar a whenever sqlerror continue none
--para regresar a la configuración original.

whenever sqlerror exit rollback;

connect sys@ocpbda2_shared/system2 as sysdba

create table oswaldo0501.t02_dispatcher_config as (
  select 1 id, dispatchers, connections, sessions, service from v$dispatcher_config
);

create table oswaldo0501.t03_dispatcher as (
  select 1 id, name, network, status, messages, messages as messages_mb, created as circuits_created, idle*60*100 as idle_min
  from v$dispatcher
);

create table oswaldo0501.t04_shared_server as (
  select 1 id, name, status, messages, messages as messages_mb, requests, idle*60*100 as idle_min, busy*60*100 as busy_min
  from v$shared_server
);

create table oswaldo0501.t05_queue as (
  select 1 id, queued, wait, totalq from v$queue
);

create table oswaldo0501.t06_virtual_circuit as (
  select 1 id, c.circuit, d.name, c.server, c.status, c.queue as queue
  from v$circuit c join v$dispatcher d on c.dispatcher = d.paddr
);

commit;