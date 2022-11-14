
Prompt conectando como sysdba
connect sys/system2 as sysdba

create table oswaldo0404.t01_memory_areas(
  id NUMBER,
  sample_date date default sysdate not null,
  redo_buffer_mb number,
  buffer_cache_mb number,
  shared_pool_mb number,
  large_pool_mb number,
  java_pool_mb number,
  total_sga_mb1 number,
  total_sga_mb2 number,
  total_sga_mb3 number,
  total_pga_mb1 number,
  total_pga_mb2 number,
  max_pga number
);

insert into oswaldo0404.t01_memory_areas (
  id, redo_buffer_mb, buffer_cache_mb, shared_pool_mb, large_pool_mb,
  java_pool_mb, total_sga_mb1, total_sga_mb2, total_sga_mb3,
  total_pga_mb1, total_pga_mb2, max_pga
) values (
  1,
  (select trunc(BYTES/1024/1024, 2) from v$sgainfo where name='Redo Buffers'),
  (select trunc(BYTES/1024/1024, 2) from v$sgainfo where name='Buffer Cache Size'),
  (select trunc(BYTES/1024/1024, 2) from v$sgainfo where name='Shared Pool Size'),
  (select trunc(BYTES/1024/1024, 2) from v$sgainfo where name='Large Pool Size'),
  (select trunc(BYTES/1024/1024, 2) from v$sgainfo where name='Java Pool Size'),
  (select
    trunc(
      (
        (select sum(value) from v$sga)-
        (select current_size from v$sga_dynamic_free_memory)
      )/1024/1024, 2
    ) as memoria_sga_1 from dual),
  (select
    trunc(
    (
      (select sum(current_size) from v$sga_dynamic_components) +
      (select value from v$sga where name ='Fixed Size') +
      (select value from v$sga where name ='Redo Buffers')
    ) /1024/1024, 2
  ) as memoria_sga_2 from dual ),
  (select
    trunc(
      (
        select sum(bytes) from v$sgainfo where name not in (
        'Granule Size',
        'Maximum SGA Size',
        'Startup overhead in Shared Pool',
        'Free SGA Memory Available',
        'Shared IO Pool Size'
        )
      ) /1024/1024, 2
    ) as memoria_sga_3 from dual),
  (select trunc(value/1024/1024,2) memoria_pga_1
  from v$pgastat where name ='aggregate PGA target parameter'),
  (select trunc(current_size/1024/1024,2) memoria_pga_2
  from v$sga_dynamic_free_memory),
  (select trunc(VALUE/1024/1024, 2) FROM v$pgastat WHERE name='maximum PGA allocated')
);

create table oswaldo0404.t02_memory_param_values(
  id NUMBER,
  sample_date date default sysdate not null,
  memory_target number,
  sga_target number,
  pga_aggregate_target number,
  shared_pool_size number,
  large_pool_size number,
  java_pool_size number,
  db_cache_size number
);

insert into oswaldo0404.t02_memory_param_values(
  id, memory_target, sga_target, pga_aggregate_target, shared_pool_size,
  large_pool_size, java_pool_size, db_cache_size
) values(
  1,
  (select value/1024/1024 from v$parameter where name = 'memory_target'),
  (select value from v$parameter where name = 'sga_target'),
  (select value from v$parameter where name = 'pga_aggregate_target'),
  (select value from v$parameter where name = 'shared_pool_size'),
  (select value from v$parameter where name = 'large_pool_size'),
  (select value from v$parameter where name = 'java_pool_size'),
  (select value from v$parameter where name = 'db_cache_size')
);

commit;