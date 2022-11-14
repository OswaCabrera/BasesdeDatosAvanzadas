--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 02/09/2022
--@Descripción: Consulta de roles

whenever sqlerror exit rollback;

Prompt conectando como usuario sys
connect sys/system1 as sysdba

create table oswaldo0104.t02_db_roles as
select role_id,role
from dba_roles;

create table oswaldo0104.t03_dba_privs as
select privilege
from dba_sys_privs;
