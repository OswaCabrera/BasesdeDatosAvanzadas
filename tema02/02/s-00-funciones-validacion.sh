#!/bin/bash

fv_list_prefix(){
  p_index=${1}
  user=$USER;
  host=$HOSTNAME
  year=`date '+%Y'`
  month=`date '+%m'`
  day=`date '+%d'`
  time=`date '+%H:%M:%S'`
  host_length=`echo -n $host | wc -m`
  user_length=`echo -n $user | wc -m`
  total_length=$(($host_length+$user_length));

  if [ $p_index -eq "0" ]; then
    p_index=1
  fi;

  host_index=$p_index
  user_index=$p_index

  if [ $p_index -gt $host_length ]; then
    host_index=$(($host_index%$host_length))
  fi;

  if [ $p_index -gt $user_length ]; then
     user_index=$(($user_index%$user_length))
  fi;

  if [ $host_index -eq "0" ]; then
    host_index=$host_length;
  fi;

  if [ $user_index -eq "0" ]; then
    user_index=$user_length;
  fi;

  letter_host=$(echo $host | cut -c$host_index)
  letter_user=$(echo $user | cut -c$user_index)

  row=`echo 00$p_index | tail -c4`
  row+=`echo 00$total_length | tail -c4`
  row+="-"
  row+=`echo "$letter_user" | tr '[:lower:]' '[:upper:]'` 
  row+="$year-"
  row+=`echo 0$month | tail -c3`
  row+="-"
  row+=`echo 0$day | tail -c3`
  row+=`echo "$letter_host" | tr '[:lower:]' '[:upper:]'` 
  row+="$time"
  echo "$row - OK - ";
}

fv_header(){

  fecha=`date '+%Y-%m-%d %H:%M:%S'`
  host_length=${#HOSTNAME}
  user_length=${#USER}
  hash=$(($host_length+$user_length))

  echo "========== Validacion de resultados ========== ";
  echo "1. Fecha............................$fecha"
  echo "2. Nombre del Host ................ $HOSTNAME"
  echo "3. Nombre del usuario ............. $USER"
  echo "4. fv_hsh_user .................... $hash"
  echo ""
}

# Param 1: Número de renglón
# Param 2: Status - resultado de la validación
# Param 3: Valor esperado
# Param 4: Valor obtenido
# Param 5: Mensaje positivo
# Param 6: Mensaje de error
fv_assert(){
  row=${1}
  condicion="${2}"
  esperado="${3}"
  obtenido="${4}"
  mensaje="${5}"
  mensajeError="${6}"

  if [ "${condicion}" = "0" ]; then
    echo "$(fv_list_prefix ${row}) ${mensaje}"
  else
    echo "===> ERROR. ${mensajeError} Se esperaba ${esperado}, Obtenido: '${obtenido}', status: ${condicion}"
    exit 200
  fi;
}


#fv_list_prefix 1
#fv_list_prefix 2
#fv_list_prefix 3
#fv_list_prefix 4
#fv_list_prefix 5
#fv_list_prefix 6
#fv_list_prefix 7
#fv_list_prefix 8
#fv_list_prefix 9
#fv_list_prefix 10
#fv_list_prefix 11
#fv_list_prefix 12
#fv_list_prefix 13
#fv_list_prefix 14
#fv_list_prefix 15
#fv_list_prefix 16
#fv_list_prefix 17
