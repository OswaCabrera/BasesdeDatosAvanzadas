whenever sqlerror exit rollback;

-- para propósitos de pruebas y propósitos académicos se incluye el password
-- no hacer esto en sistemas reales.

Prompt conectando como usuario sys
connect sys/system2 as sysdba

create table oswaldo0403.t01_redo_log_buffer(
  redo_buffer_size_param_mb number,
  redo_buffer_sga_info_mb number,
  resizeable varchar(3)
);

insert into oswaldo0403.t01_redo_log_buffer (redo_buffer_size_param_mb, redo_buffer_sga_info_mb, resizeable)
values (
  (select value/1024/1024 from v$parameter where name = 'log_buffer'),
  (select BYTES/1024/1024 from v$sgainfo where name = 'Redo Buffers'),
  (select resizeable from v$sgainfo where name = 'Redo Buffers')
);