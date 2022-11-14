connect sys/system2 as sysdba

whenever sqlerror exit rollback;

alter system set memory_target = 0M scope=memory;


alter system set sga_target = 404m scope=memory;

--parametros a 0
alter system set shared_pool_size = 0 scope=memory;
alter system set large_pool_size = 0 scope=memory;
alter system set java_pool_size = 0 scope=memory;
alter system set db_cache_size = 0 scope=memory;
alter system set streams_pool_size = 0 scope=memory;

exec dbms_session.sleep(5);

insert into oswaldo0404.t02_memory_param_values(
  id, memory_target, sga_target, pga_aggregate_target, shared_pool_size,
  large_pool_size, java_pool_size, db_cache_size
) values(
  2,
  (select value/1024/1024 from v$parameter where name = 'memory_target'),
  (select ((select sum(value) from v$sga) -
    (select current_size from v$sga_dynamic_free_memory)
      )/1024/1024 "sga_target"
    from dual),
  318,
  (select value from v$parameter where name = 'shared_pool_size'),
  (select value from v$parameter where name = 'large_pool_size'),
  (select value from v$parameter where name = 'java_pool_size'),
  (select value from v$parameter where name = 'db_cache_size')
);
