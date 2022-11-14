
whenever sqlerror exit rollback;


Prompt Conectando con sys
connect sys/system2 as sysdba

--Se establece el modo manual de la memoria
alter system set memory_target = 0 scope=memory;
alter system set sga_target = 0 scope=memory;
--Los parameros anteriores toman efecto inmediato y no requieren un reinicio de la instancia
--Es decir columna issys_modifiable en v$parameter es immediate

--Espera de 5 segundos
exec dbms_session.sleep(5)


--Se agrega registro a t02_memory_param_values
insert into oswaldo0404.t02_memory_param_values(
  id,
  memory_target,
  sga_target,
  pga_aggregate_target,
  shared_pool_size,
  large_pool_size,
  java_pool_size,
  db_cache_size
) values(
  3,
  (select value/1024/1024 from v$parameter where name = 'memory_target'),
  (select value/1024/1024 from
    v$parameter where name like 'sga_target'),
  (select value/1024/1024 from v$parameter where name = 'pga_aggregate_target'),
  (select value/1024/1024 from v$parameter where name = 'shared_pool_size'),
  (select value/1024/1024 from v$parameter where name = 'large_pool_size'),
  (select value/1024/1024 from v$parameter where name = 'java_pool_size'),
  (select value/1024/1024 from v$parameter where name = 'db_cache_size')
);


commit;