
connect oswaldo0601/oswaldo

whenever sqlerror exit rollback;

create table empleado(
  empleado_id number(10),
  nombre_completo varchar2(150) NOT NULL,
  num_cuenta  varchar2(15) NOT NULL UNIQUE,
  expediente blob NOT NULL
);

alter table empleado add CONSTRAINT empleado_pk PRIMARY KEY (empleado_id);

--create index empleado_num_cuenta_uix on empleado(num_cuenta);

select *
from user_segments
where segment_name like '%EMPLEADO%';

commit;

insert into empleado(empleado_id, nombre_completo, num_cuenta, expediente) 
values (1,'Oswaldo Cabrera Pérez', '316110451', EMPTY_BLOB());


--alter table empleado allocate extent;

select *
from user_segments
where segment_name like '%EMPLEADO%';

select segment_name, segment_type, tablespace_name, bytes/1000 as segment_kbs, blocks, extents
from user_segments where segment_name = '%EMPLEADO%';