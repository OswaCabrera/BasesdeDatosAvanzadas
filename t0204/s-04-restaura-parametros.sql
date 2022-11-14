--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 16/09/2022
--@Descripción: Restauracion de un spfile a partir de un pfile


-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

whenever sqlerror exit rollback;

shutdown

create spfile from pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt';

startup