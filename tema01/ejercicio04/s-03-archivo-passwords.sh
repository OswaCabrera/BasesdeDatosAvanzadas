#!/bin/bash

#--@Autor: Oswaldo Cabrera Pérez
#--@Fecha creación: 02/09/2022
#--@Descripción: Respaldo de passwords



echo "Obteniendo el SID de la base de datos"

sid=${ORACLE_SID}

archivoPwd="${ORACLE_HOME}/dbs/orapw${sid}"
archivoPwdBackup="/home/${USER}/backups/orapw${sid}"

if ! [ -f ${archivoPwdBackup} ]; then
  echo "==> Respaldando archivo de passwords"
  mkdir -p /home/"${USER}"/backups
  cp ${archivoPwd} ${archivoPwdBackup}
else
  echo "==> El archivo ${archivoPwd} ya fue respaldado"
fi

if [ -f ${archivoPwd} ]; then
  echo "==> Eliminando el archivo de passwords"
  rm "${archivoPwd}"
else
  echo "==> El archivo de passwords ya fue eliminado"
fi

echo "==> Creando a un nuevo archivo"

orapwd FILE=${archivoPwd} FORMAT=12.2 \
  FORCE=Y \
  SYS=password \
  SYSBACKUP=password
