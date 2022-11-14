--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 10/09/2022
--@Descripción: Creacion del diccionario de datos

Prompt conectando como usuario sys
connect sys/system2 as sysdba


@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

disconnect 

connect system/system2

@?/sqlplus/admin/pupbld.sql