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

alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=memory;

alter system set shared_servers=4 scope=memory;

show parameter dispatchers

show parameter shared_servers

alter system register;

select program, pid, pname from v$process where pname like'S0%' or  
pname like'D0%' order by program;