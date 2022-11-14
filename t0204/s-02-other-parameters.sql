--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 16/09/2022
--@Descripción: Ejercicio 4 tema 2 BDA


-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

whenever sqlerror exit rollback;

create table oswaldo0204.t02_other_parameters as (
  select num,
    name,
    value,
    default_value,
    isses_modifiable as is_session_modifiable,
    issys_modifiable as is_system_modifiable
  from 
    v$system_parameter
);