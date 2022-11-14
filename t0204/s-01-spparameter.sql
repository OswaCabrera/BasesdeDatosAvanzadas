--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 16/09/2022
--@Descripción: Obtención de parámetros usando create pfile


-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

whenever sqlerror exit rollback;

create pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt' from spfile;


create table oswaldo0204.t01_spparameters as (
  select name, value
  from v$spparameter
  where value is not null
);
