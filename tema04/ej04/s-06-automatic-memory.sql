connect sys/system2 as sysdba

whenever sqlerror exit rollback;


alter system set memory_max_target = 786M scope = spfile;

shutdown immediate
startup

alter system set memory_target = 786M scope=memory;

alter system set sga_target = 0 scope=memory;
alter system set pga_aggregate_target = 0  scope=memory;
alter system set shared_pool_size = 0 scope=memory;
alter system set large_pool_size = 0 scope=memory;
alter system set java_pool_size = 0 scope=memory;
alter system set streams_pool_size = 0 scope=memory;
alter system set db_cache_size = 0 scope=memory;

exec dbms_session.sleep(5);

insert into oswaldo0404.t02_memory_param_values(
  id, memory_target, sga_target, pga_aggregate_target, shared_pool_size,
  large_pool_size, java_pool_size, db_cache_size
) values(
  4,
  (select value/1024/1024 from v$parameter where name = 'memory_target'),
  (select value/1024/1024 from
    v$parameter where name like 'sga_target'),
  (select value from v$parameter where name = 'pga_aggregate_target'),
  (select value from v$parameter where name = 'shared_pool_size'),
  (select value from v$parameter where name = 'large_pool_size'),
  (select value from v$parameter where name = 'java_pool_size'),
  (select value from v$parameter where name = 'db_cache_size')
);

commit;