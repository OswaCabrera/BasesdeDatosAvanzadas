#!/bin/bash

#--@Autor: Oswaldo Cabrera Pérez
#--@Fecha creación: 06/09/2022
#--@Descripción: Creación del archivo de contraseñas

export ORACLE_SID="ocpbda2"

sid=${ORACLE_SID}

archivoPwd="${ORACLE_HOME}/dbs/orapw${sid}"

echo "==> Creando a un nuevo archivo"

orapwd FILE=${archivoPwd} FORMAT=12.2 \
  FORCE=Y \
  SYS=password

