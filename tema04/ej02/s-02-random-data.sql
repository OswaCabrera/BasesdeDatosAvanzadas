--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 16/09/2022
--@Descripción: Obtención de parámetros usando create pfile


-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario oswaldo0402
connect oswaldo0402/oswaldo

whenever sqlerror exit rollback;

Prompt creando tabla t03_random_data
create table t03_random_data(
  id number,
  random_string varchar2(1024)
);

Prompt creando tabla t04_db_buffer_status
create table t04_db_buffer_status(
  id number generated always as identity,
  total_bloques number,
  status varchar2(10),
  evento varchar2(30)
);

declare
  v_rows number;
  v_query varchar2(100);
begin
  v_rows := 1000*10;
  v_query :=
    'insert into t03_random_data(id, random_string) values (:ph1,:ph2)';
  for v_index in 1 .. v_rows loop
    execute immediate v_query
     using v_index, dbms_random.string('P',1016);
  end loop;
end;
/
commit;

Prompt conectando como usuario sys
connect sys/system2 as sysdba

insert into oswaldo0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de carga' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'OSWALDO0402'
  )
  group by status;
commit;

alter system flush buffer_cache;

insert into oswaldo0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de vaciar db buffer' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'OSWALDO0402'
  )
  group by status;
commit;

shutdown immediate
startup


prompt agregando tercer registro
insert into oswaldo0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después del reinicio' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'OSWALDO0402'
  )
  group by status;

commit;

prompt modificar un registro de la tabla
update oswaldo0402.t03_random_data set random_string= upper(random_string)
where id = 100;

prompt agregando tercer registro
insert into oswaldo0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después del cambio 1' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'OSWALDO0402'
  )
  group by status;


prompt En otra terminal crear una sesión con el usuario oswaldo0402
Prompt consultar el registro modificado 3 veces
pause "select * from t03_random_data where id =100", [enter] para continuar

insert into oswaldo0402.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de 3 consultas' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'OSWALDO0402'
  )
  group by status;
commit;

prompt Mostrando los datos finales
select * from oswaldo0402.t04_db_buffer_status;