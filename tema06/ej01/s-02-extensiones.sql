whenever sqlerror exit rollback;

connect oswaldo0601/oswaldo

create table str_data(
  str char(1024)
) segment creation immediate, pctfree 0;



whenever sqlerror exit rollback;
set serveroutput on
declare
  v_query varchar2(1000);
  v_index number;
  v_char char(1024);
begin
  --inserta 56 registros
  for v_index in 1..56 loop
    execute immediate 'insert into str_data values(:num_aleatorio)'
      using  dbms_random.string('L', 1);
  end loop;
  commit;
end;
/

select * from user_extents where segment_name='STR_DATA';

select rowid from str_data order by 1;

select substr(rowid,1,15) as codigo_bloque ,count(*) total_registros
from str_data
group by substr(rowid,1,15)
order by codigo_bloque;


create table t03_random_str(
  str varchar2(1024)
);

whenever sqlerror exit rollback;
set serveroutput on
declare
  v_query varchar2(1000);
  v_index number;
  v_char char(1024);
begin
  --inserta 56 registros
  for v_index in 1..280 loop
    execute immediate 'insert into t03_random_str values(:num_aleatorio)'
      using  dbms_random.string('L', 1);
  end loop;
  commit;
end;
/

create table t04_space_usage(
  id number,
  segment_name varchar2(128),
  unformatted_blocks number, --número de bloques reservados sin formatear
  unused_blocks number, --número de bloques reservados sin uso
  total_blocks number, --total de bloques reservados para la tabla
  free_space_0_25 number, --número de bloques con espacio libre entre el 0 y 25%
  free_space_25_50 number, --número de bloques con espacio libre entre el 25 y 50%
  free_space_50_75 number, --número de bloques con espacio libre entre el 50 y 75%
  free_space_75_100 number --número de bloques con espacio libre entre el 75 y 100%
);

create or replace procedure get_space_usage_info( p_id number) is
  v_unformatted_blocks number;
  v_0_25_free number;
  v_25_50_free number;
  v_50_75_free number;
  v_75_100_free number;
  v_not_used number;
  v_total_blocks number;
  v_unused_blocks number;
begin
--Uso del espacio a nivel de bloque.
  dbms_space.space_usage(
    segment_owner => 'JORGE0601',
    segment_name => 'T03_RANDOM_STR',
    segment_type => 'TABLE',
    unformatted_blocks => v_unformatted_blocks,
    unformatted_bytes => v_not_used,
    fs1_blocks => v_0_25_free,
    fs2_blocks => v_25_50_free,
    fs3_blocks => v_50_75_free,
    fs4_blocks => v_75_100_free,
    fs1_bytes => v_not_used,
    fs2_bytes => v_not_used,
    fs3_bytes => v_not_used,
    fs4_bytes => v_not_used,
    full_blocks => v_not_used,
    full_bytes => v_not_used
);

dbms_space.unused_space (
  segment_owner => 'OSWALDO0601',
  segment_name => 'T03_RANDOM_STR',
  segment_type => 'TABLE',
  total_blocks => v_total_blocks,
  total_bytes => v_not_used,
  unused_blocks => v_unused_blocks,
  unused_bytes => v_not_used,
  last_used_extent_file_id => v_not_used,
  last_used_extent_block_id => v_not_used,
  last_used_block => v_not_used
);



end;
/
show errors

