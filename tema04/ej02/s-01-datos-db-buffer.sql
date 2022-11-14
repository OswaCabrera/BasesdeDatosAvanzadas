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

Prompt conectando como usuario sys
connect sys/system2 as sysdba

create table oswaldo0402.t01_db_buffer_cache(
  block_size number,
  current_size number,
  buffers number,
  target_buffers number,
  prev_size number,
  prev_buffers number,
  default_pool_size number
);

insert into oswaldo0402.t01_db_buffer_cache (
  block_size, current_size, buffers, target_buffers, prev_size, prev_buffers, default_pool_size
) 
values(
  (select block_size from v$buffer_pool),
  (select current_size from v$buffer_pool),
  (select buffers from v$buffer_pool),
  (select target_buffers from v$buffer_pool),
  (select prev_size from v$buffer_pool),
  (select prev_buffers from v$buffer_pool),
  (select value from v$parameter where name='db_cache_size')
);

create table oswaldo0402.t02_db_buffer_sysstats(
  db_blocks_gets_from_cache number,
  consistent_gets_from_cache number,
  physical_reads_cache number,
  cache_hit_radio generated always as ( trunc(1 - ((physical_reads_cache/(db_blocks_gets_from_cache + consistent_gets_from_cache))), 6 ) )
); 

insert into oswaldo0402.t02_db_buffer_sysstats (db_blocks_gets_from_cache, consistent_gets_from_cache, physical_reads_cache)
values(
  (select value from v$sysstat where name ='db block gets from cache'),
  (select value from v$sysstat where name ='consistent gets from cache'),
  (select value from v$sysstat where name ='physical reads cache')
);

commit;