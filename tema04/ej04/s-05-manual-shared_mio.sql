connect sys/system2 as sysdba

whenever sqlerror exit rollback;

alter system set sga_target = 0 scope=memory;
alter system set memory_target = 0 scope=memory;

alter system set db_cache_size = 136m scope=memory;
alter system set shared_pool_size = 240m scope=memory;
alter system set large_pool_size = 20m  scope=memory;
alter system set java_pool_size = 4m scope=memory;

exec dbms_session.sleep(5);

insert into oswaldo0404.t02_memory_param_values(
  id, memory_target, sga_target, pga_aggregate_target, shared_pool_size,
  large_pool_size, java_pool_size, db_cache_size
) values(
  3,
  (select value/1024/1024 from v$parameter where name = 'memory_target'),
  (select ((select sum(value) from v$sga) -
    (select current_size from v$sga_dynamic_free_memory)
      ) "sga_target"
    from dual),
  (select value/1024/1024 from v$parameter where name = 'pga_aggregate_target'),
  (select value/1024/1024 from v$parameter where name = 'shared_pool_size'),
  (select value/1024/1024 from v$parameter where name = 'large_pool_size'),
  (select value/1024/1024 from v$parameter where name = 'java_pool_size'),
  (select value/1024/1024 from v$parameter where name = 'db_cache_size')
);