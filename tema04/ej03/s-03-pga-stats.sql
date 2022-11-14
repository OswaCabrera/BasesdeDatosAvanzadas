whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

create table oswaldo0403.t04_pga_stats(
  max_pga_mb number,
  pga_target_param_calc_mb number,
  pga_target_param_actual_mb number,
  pga_total_actual_mb number ,
  pga_in_use_actual_mb number,
  pga_free_memory_mb number,
  pga_process_count number,
  pga_cache_hit_percentage number
);

insert into oswaldo0403.t04_pga_stats
  (max_pga_mb, pga_target_param_calc_mb, pga_target_param_actual_mb, pga_total_actual_mb,
  pga_in_use_actual_mb, pga_free_memory_mb, pga_process_count, pga_cache_hit_percentage)
  values(
    (select value/1024/1024 from v$pgastat where name = 'maximun PGA allocated'),
    (select value/1024/1024 from v$pgastat where name = 'aggregate PGA target parameter'),
    (select value/1024/1024 from v$parameter where name = 'pga_aggregate_target'),
    (select value/1024/1024 from v$pgastat where name = 'total PGA allocated'),
    (select value/1024/1024 from v$pgastat where name = 'total PGA inuse'),
    (select value/1024/1024 from v$pgastat where name = 'total freeable PGA memory'),
    (select value from v$pgastat where name = 'process count'),
    (select value from v$pgastat where name = 'cache hit percentage')
  );

select * from oswaldo0403.t04_pga_stats;

commit;