--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 02/09/2022
--@Descripción: Creacion de spifile


whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/hola1234* as sysdba


create spfile from pfile;

!ls ${ORACLE_HOME}/dbs/spfileocpbda2.ora