--@Autor: Oswaldo Cabrera Pérez
--@Fecha creación: 10/09/2022
--@Descripción: Creacion de la base de datos

Prompt conectando como usuario sys
connect sys/system2 as sysdba


startup nomount

create database ocpbda2
  user sys identified by system2
  user system identified by system2
  logfile group 1 (
    '/unam-bda/d01/app/oracle/oradata/OCPBDA2/redo01a.log',
    '/unam-bda/d02/app/oracle/oradata/OCPBDA2/redo01b.log',
    '/unam-bda/d03/app/oracle/oradata/OCPBDA2/redo01c.log') size 50m
blocksize 512,
  group 2 (
    '/unam-bda/d01/app/oracle/oradata/OCPBDA2/redo02a.log',
    '/unam-bda/d02/app/oracle/oradata/OCPBDA2/redo02b.log',
    '/unam-bda/d03/app/oracle/oradata/OCPBDA2/redo02c.log') size 50m
blocksize 512,
  group 3 (
    '/unam-bda/d01/app/oracle/oradata/OCPBDA2/redo03a.log',
    '/unam-bda/d02/app/oracle/oradata/OCPBDA2/redo03b.log',
    '/unam-bda/d03/app/oracle/oradata/OCPBDA2/redo03c.log') size 50m
blocksize 512
  maxloghistory 1
  maxlogfiles 16
  maxlogmembers 3
  maxdatafiles 1024
  character set AL32UTF8
  national character set AL16UTF16
  extent management local
  datafile '/u01/app/oracle/oradata/OCPBDA2/system01.dbf'
  size 700m reuse autoextend on next 10240k maxsize
unlimited
  sysaux datafile
'/u01/app/oracle/oradata/OCPBDA2/sysaux01.dbf'
    size 550m reuse autoextend on next 10240k maxsize
unlimited
  default tablespace users
    datafile '/u01/app/oracle/oradata/OCPBDA2/users01.dbf'
    size 500m reuse autoextend on maxsize unlimited
  default temporary tablespace tempts1
    tempfile '/u01/app/oracle/oradata/OCPBDA2/temp01.dbf'
    size 20m reuse autoextend on next 640k maxsize unlimited
  undo tablespace undotbs1
    datafile '/u01/app/oracle/oradata/OCPBDA2/undotbs01.dbf'
    size 200m reuse autoextend on next 5120k maxsize unlimited;


alter user sys identified by system2;
alter user system identified by system2;
