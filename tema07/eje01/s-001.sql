select file_name, file_id, bytes/1024/1024 as bytes_mb
from dba_data_files;

select tablespace_name, initial_extent
from dba_tablespaces;

select tablespace_name, blocks, bytes/1024/1024 as size_mb 
from dba_free_space where tablespace_name = 'STORE_TBS_MULTIPLE';

create user oswaldo_072 identified by oswaldo quota unlimited on store_tbs_multiple DEFAULT TABLESPACE store_tbs_multiple;

create table oswaldo_tbs_multiple(
  str varchar2(1024)
) segment creation immediate;

select s . segment_name , s . segment_type , s . tablespace_name ,
( s . bytes /1024) as segmentKBS , s . blocks , s . extents
from user_segments s
join user_lobs l on s . segment_name = l . segment_name
or s . segment_name = l . index_name
or s . segment_name like '%OSWALDO_TBS_MULTIPLE%';

alter table oswaldo_072.oswaldo_tbs_multiple allocate extent;

select us.segment_name, us.segment_type, us.tablespace_name, us.bytes/1024 as segment_kbs, us.blocks, us.extents 
from user_segments us
--join dba_data_files df
--on df.tablespace_name = us.tablespace_name
where us.segment_name = 'OSWALDO_TBS_MULTIPLE';

ALTER USER oswaldo_072 DEFAULT TABLESPACE STORE_TBS_MULTIPLE;
ALTER USER oswaldo_072 quota unlimited on STORE_TBS_MULTIPLE;

drop table oswaldo_tbs_multiple;
TRUNCATE table oswaldo_tbs_multiple;

select * from user_segments where tablespace_name != 'SYSTEM' AND tablespace_name != 'SYSAUX' ;

COMMIT;
grant create session, create table, create procedure to oswaldo_072;

conn oswaldo_072/oswaldo 
conn sys/system2 as sysdba

set serveroutput on
declare
  v_query varchar2(1000);
  v_index number;
  v_char char(1024);
begin
  --inserta 56 registros
  for v_index in 1..512 loop
    execute immediate 'insert into oswaldo_store_multiple values(:num_aleatorio)'
      using  dbms_random.string('L', 1);
  end loop;
  commit;
end;
/