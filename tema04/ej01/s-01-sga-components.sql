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

create table oswaldo0401.t01_sga_components(
  memory_target_param number,
  fixed_size number,
  variable_size number,
  database_buffers number,
  redo_buffers number,
  total_sga number
);

declare
  v_total_ram number;
begin
  select trunc(sum(value)/1024/1024, 2) into v_total_ram from v$sga;

insert into oswaldo0401.t01_sga_components(memory_target_param,
  fixed_size, variable_size, database_buffers,
  redo_buffers, total_sga) 
  values (
    --memory target
    ( select VALUE/1024/1024 from v$parameter where name ='memory_target' ),
    --fixed size
    ( select trunc(value/1024/1024, 2) from v$SGA where name = 'Fixed Size' ),
    --variable_size
    ( select trunc(value/1024/1024, 2) from v$SGA where name = 'Variable Size' ),
    --Database buffers
    ( select trunc(value/1024/1024, 2) from v$SGA where name = 'Database Buffers' ),
    --Redo Buffers
    ( select trunc(value/1024/1024, 2) from v$SGA where name = 'Redo Buffers' ),
    --Total SGA
    v_total_ram
  );
end;
/

create table oswaldo0401.t02_sga_dynamic_components as (
  select component component_name, trunc(current_size/1024/1024, 2) current_size_mb, oper_count operation_count,
  last_oper_type last_operation_type, last_oper_time last_operation_time
  from v$sga_dynamic_components
);

create table oswaldo0401.t03_sga_max_dynamic_component as (
  select component component_name, trunc(current_size/1024/1024, 2) current_size_mb
  from v$sga_dynamic_components 
  where current_size = (
  select Max(current_size) from v$sga_dynamic_components)
);

create table oswaldo0401.t04_sga_min_dynamic_component as ( 
  select component component_name, trunc(current_size/1024/1024, 2) current_size_mb
  from v$sga_dynamic_components 
  where current_size = (
    select Min(current_size) from v$sga_dynamic_components 
    where current_size > 0  )
);

create table oswaldo0401.t05_sga_memory_info as(
  select name, bytes/1024/1024 current_size_mb
  from v$sgainfo
  where name = 'Maximum SGA Size' or name='Free SGA Memory Available'
);

create table oswaldo0401.t06_sga_resizeable_components as (
  select name from v$sgainfo where resizeable = 'Yes'
);

commit;

create table oswaldo0401.t07_sga_resize_ops as (
  select component, oper_type, parameter, initial_size/1024/1024 initial_size_mb,
  target_size/1024/1024 target_size_mb, final_size/1024/1024 final_size_mb,
  (initial_size - final_size)/1024/1024 increment_mb, status, start_time, end_time
  from v$sga_resize_ops
);

commit;

select * from oswaldo0401.t01_sga_components;

select * from oswaldo0401.t02_sga_dynamic_components order by current_size_mb desc;

select * from oswaldo0401.t03_sga_max_dynamic_component;

select * from oswaldo0401.t04_sga_min_dynamic_component;

select * from oswaldo0401.t05_sga_memory_info;

select * from oswaldo0401.t06_sga_resizeable_components;


