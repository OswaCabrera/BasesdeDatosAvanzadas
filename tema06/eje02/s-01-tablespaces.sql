connect sys/system2 as sysdba

create tablespace store_tbs1
datafile ’/u01/app/oracle/oradata/OCPBDA2/store_tbs01.dbf’ size 20 m
extent management local autoallocate
segment space management auto ;

create tablespace store_tbs_multiple
datafile ’/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_01.dbf’ size 10 m ,
’/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_02.dbf’ size 10 m ,
’/u01/app/oracle/oradata/OCPBDA2/store_tbs_multiple_03.dbf’ size 10 m
extent management local autoallocate
segment space management auto ;

create bigfile tablespace store_tbs_big
datafile ’/u01/app/oracle/oradata/OCPBDA2/store_tbs_big.dbf’ size 100 m autoextend off
extent management local autoallocate
segment space management auto ;

create tablespace store_tbs_zip
datafile ’/u01/app/oracle/oradata/OCPBDA2/store_tbs_zip.dbf’ size 10 m
default index compress advanced high ;

create temporary tablespace store_tbs_temp
tempfile ’/u01/app/oracle/oradata/OCPBDA2/store_tbs_temp’ size 20 m
reuse
extent management local uniform size 16 M ;

create tablespace store_tbs_custom
datafile ’/u01/app/oracle/oradata/OCPBDA2/store_tbs_custom_01 .dbf’ size 10 m
reuse
autoextend on next 1 M maxsize 30 M
nologging
blocksize 8 K
offline
extent management local uniform size 64 K
segment space management auto;