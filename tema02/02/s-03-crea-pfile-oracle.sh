#!/bin/bash

#@Autor: Oswaldo Cabrera Pérez
#@Fecha creación: 02/09/2022
#@Descripción: Creación de pfile

echo "1. Creando un archivo de parámetros básico"
export ORACLE_SID=ocpbda2
pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora

if [ -f "${pfile}" ]; then
  read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
fi;

echo \
"db_name='${ORACLE_SID}'
memory_target=768M
control_files=(/unam-bda/d01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
              /unam-bda/d02/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl,
              /unam-bda/d03/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl)
" >$pfile
echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}
