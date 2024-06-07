#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

function region {

  list_region=()
  available_region=()

  available_region=($(timedatectl list-timezones))

  for ((i=0; i<${#available_region[@]}; i++)); do

    list_region+=("${available_region[$i]}" "")

  done
  
  message="\nListado de las regiones disponibles"

  new_region=$(dialog --stdout --title "$title" --single-quoted --menu "$message" 0 0 0 "${list_region[@]}" --no-items)

  timedatectl set-timezone $new_region

}

actual_region=$(timedatectl show | grep 'Timezone' | cut --complement -c -9)

message="\n¿Desea cambiar la región?, ahora mismo está en '$actual_region'"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  region 

fi
