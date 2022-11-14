--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 02/09/2022
--@Descripción: 


whenever sqlerror exit rollback;

Prompt conectando como usuario oswaldo0104
connect oswaldo0104/oswaldo

create table t04_my_schema (
  username varchar2(128),
  schema_name varchar2(128)
);

grant insert on t04_my_schema to sys;
grant insert on t04_my_schema to public;
grant insert on t04_my_schema to sysbackup;

disconnect

Promt conectando como oswaldo0104 as sysdba
connect oswaldo0104/oswaldo as sysdba

insert into oswaldo0104.t04_my_schema (username,schema_name)
  values (
    sys_context('USERENV','CURRENT_USER'),
    sys_context('USERENV','CURRENT_SCHEMA')
);

disconnect 


Promt conectando como oswaldo0105
connect oswaldo0105/oswaldo as sysoper

insert into oswaldo0104.t04_my_schema (username,schema_name)
  values (
    sys_context('USERENV','CURRENT_USER'),
    sys_context('USERENV','CURRENT_SCHEMA')
);

disconnect 


Promt conectando como oswaldo0106
connect oswaldo0106/oswaldo as sysbackup

insert into oswaldo0104.t04_my_schema (username,schema_name)
  values (
    sys_context('USERENV','CURRENT_USER'),
    sys_context('USERENV','CURRENT_SCHEMA')
);

disconnect 

Prompt conectando como sysdba
connect sysdba/system1 as sysdba

select username,sysdba,sysoper,sysbackup from v$pwfile_users;

alter user sys identified by system1;

whenever sqlerror continue none;

