select file_name, file_id, bytes/1024/1024 as bytes_mb
from dba_data_files;

select tablespace_name, initial_extent
from dba_tablespaces;

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

grant select on dba_free_space to oswaldo_072;

commit;

alter database datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_01.dbf' offline;
alter database datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_02.dbf' offline;
alter database datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_03.dbf' offline;

alter tablespace store_tbs_multiple offline;
alter tablespace store_tbs_multiple online;

select file_name, file_id, online_status
from dba_data_files;



alter tablespace store_tbs_multiple
  rename datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_01.dbf',
                  '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_02.dbf',
                  '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_03.dbf'
                  to '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_013.dbf',
                     '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_023.dbf',
                     '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_033.dbf'; 
                     
                     commit;
                     
alter database move datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_013.dbf' to '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_01.dbf';
alter database move datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_023.dbf' to '/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_02.dbf';
alter database move datafile '/u01/app/oracle/oradata/OCPBDA2/store_tbs1.dbf' to '/u01/app/oracle/oradata/OCPBDA2/store_tbs01.dbf';

commit;

alter tablespace store_tbs1
add datafile 
 '/u01/app/oracle/oradata/OCPBDA2/store_tbs01.dbf' size 20m
;

alter tablespace store_tbs1 online ;
-- EJERCICIO 3

select group#,sequence#,bytes, bytes/(1024*1024) size_mb, blocksize,
 members,archived,status
from v$log; 



select * from v$log_history;
--

select l.group#, l.sequence#, l.bytes/(1024*1024) as size_mb, l.blocksize,
 l.members,l.archived, l.status,
 (select lh.first_change#  from v$log_history lh where l.sequence# = lh.sequence#) as LOWEST_SNC,
 (select lh.first_time  from v$log_history lh where l.sequence# = lh.sequence#) as LOWEST_TIME_SNC,
 (select lh.next_change#  from v$log_history lh where l.sequence# = lh.sequence#) as HIGHEST_SCN
from v$log l;
--join v$log_history lh on l.sequence# = lh.sequence#;


select group#, status, type, member
from v$logfile;

alter database
  add logfile
  group 4 ('/unam-bda/d01/app/oracle/oradata/OCPBDA2/redo04a.log',
          '/unam-bda/d02/app/oracle/oradata/OCPBDA2/redo04b.log')
  size 80m reuse;
  
alter database
  add logfile
  group 5 ('/unam-bda/d01/app/oracle/oradata/OCPBDA2/redo05a.log',
          '/unam-bda/d02/app/oracle/oradata/OCPBDA2/redo05b.log')
  size 80m reuse;
  
alter database
  add logfile
  group 6 ('/unam-bda/d01/app/oracle/oradata/OCPBDA2/redo06a.log',
          '/unam-bda/d02/app/oracle/oradata/OCPBDA2/redo06b.log')
  size 80m reuse;
  
alter database
add logfile member '/unam-bda/d03/app/oracle/oradata/OCPBDA2/redo04c.log' to group 4;

alter database
add logfile member '/unam-bda/d03/app/oracle/oradata/OCPBDA2/redo05c.log' to group 5;

alter database
add logfile member '/unam-bda/d03/app/oracle/oradata/OCPBDA2/redo06c.log' to group 6;

commit;

ALTER SYSTEM SWITCH LOGFILE;

select group#,sequence#,bytes, bytes/(1024*1024) size_mb, blocksize,
 members,archived,status
from v$log; 

alter system checkpoint;

alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;

