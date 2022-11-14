whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

create table oswaldo0403.t02_shared_pool(
  shared_pool_param_mb number,
  shared_pool_sga_info_mb number,
  resizeable varchar(3),
  shared_pool_component_total number,
  shared_pool_free_memory number
);

insert into oswaldo0403.t02_shared_pool(
  shared_pool_param_mb, shared_pool_sga_info_mb, resizeable,
  shared_pool_component_total, shared_pool_free_memory
) values(
  (select value/1024/1024 from v$parameter where name = 'shared_pool_size'),
  (select BYTES/1024/1024 from v$sgainfo where name = 'Shared Pool Size'),
  (select resizeable from v$sgainfo where name = 'Shared Pool Size'),
  (select count(*) from v$sgastat where pool ='shared pool'),
  (select BYTES/1024/1024 from v$sgastat where name='free memory' and pool='shared pool')
);

create table oswaldo0403.t03_library_cache_hist as (
  select 1 id, reloads, invalidations, pins, pinhits, pinhitratio
  from v$librarycache 
  where namespace = 'SQL AREA'
);

create table oswaldo0403.test_orden_compra(id number);

Prompt ejecutando consultas con sentencias sql estáticas
set timing on
declare
    orden_compra oswaldo0403.test_orden_compra%rowtype;
  begin
    for i in 1 .. 50000 loop
      begin
        execute immediate
          'select * from oswaldo0403.test_orden_compra where id = ' || i
          into orden_compra;
        exception
          when no_data_found then
            null;
      end;
    end loop;
  end;
/
set timing off

insert into oswaldo0403.t03_library_cache_hist (id, reloads, invalidations, pins, pinhits, pinhitratio)
  select 2 id,reloads, invalidations, pins, pinhits, pinhitratio 
  from v$librarycache 
  where namespace = 'SQL AREA';

commit;

shutdown immediate

startup

Prompt capturando nuevamente estadísticas del library cache
insert into
oswaldo0403.t03_library_cache_hist (id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 3 id, reloads,invalidations,pins,pinhits,pinhitratio
    from v$librarycache
    where namespace='SQL AREA'
;
commit;

Prompt ejecutando consultas con sentencias sql preparadas
set timing on
declare
    orden_compra oswaldo0403.test_orden_compra%rowtype;
    v_query varchar(100);

  begin
    v_query := 'select * from oswaldo0403.test_orden_compra where id = :ph1';
    for i in 1 .. 50000 loop
      begin
          execute immediate v_query
          using i;
        exception
          when no_data_found then
            null;
      end;
    end loop;
  end;
/
set timing off

Prompt capturando nuevamente estadísticas del library cache
insert into
oswaldo0403.t03_library_cache_hist (id,reloads,invalidations,pins,
  pinhits,pinhitratio)
  select 4 id, reloads,invalidations,pins,pinhits,pinhitratio
    from v$librarycache
    where namespace='SQL AREA'
;
commit;