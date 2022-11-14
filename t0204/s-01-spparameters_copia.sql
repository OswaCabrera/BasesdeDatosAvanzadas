--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 16/09/2022
--@Descripción: Obtención de parámetros usando create pfile


-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

whenever sqlerror exit rollback;

create pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt' from spfile;

declare
  v_count number;
  v_username varchar2(20) := 'OSWALDO0204';
begin
  select count(*) into v_count from all_users where username=v_username;
  if v_count >0 then
    execute immediate 'drop user '||v_username|| ' cascade';
    end if;
end;
/

Prompt creando al usuario oswaldo0204
create user oswaldo0204 identified by oswaldo quota unlimited on users;
grant create session, create table, create sequence, create procedure to oswaldo0204;


create table oswaldo0204.t01_spparameters(
  name varchar2(80),
  value varchar2(255)
);

declare
  --declaración de cursor
  cursor cur_parametros is 
  select name, value
  from v$spparameter
  where value is not null;

  --declaración de variable
  v_name v$spparameter.name%type;
  v_value v$spparameter.value%type;

begin

  open cur_parametros;
  loop
    fetch cur_parametros into 
      v_name, v_value;
    exit when cur_parametros%notfound;
    insert into oswaldo0204.t01_spparameters (name, value) values (v_name, v_value);
  end loop;
  close cur_parametros;  

end;
/