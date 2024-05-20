#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

message="\nActualmente su equipo se llama '$(hostname)' ¿Desea cambiar el nombre del equipo?"

dialog --stdout --title "$title" --yesno "$message" 0 0

function input_pcname {

    message="\n¿Qué nombre desea ponerle al equipo?, para aplicarlo tendré que reiniciar el equipo"
    pcname=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

}

if [ $? -eq 0 ]; then

  while true; do

    input_pcname

    dialog --stdout --title "$title" --yesno "\nHa puesto '$pcname', ¿Está seguro de que el equipo se llame así?" 0 0

    if [ $? -eq 0 ]; then

      echo $pcname > /etc/hostname && ./functions/power_pc/main.sh
      break

    else

      dialog --stdout --title "$title" --yesno "\n¿Está seguro que quiere salit?" 0 0

      if [ $? -eq 0 ]; then

        input_pcname

      fi

    fi

  done

else

  exit

fi
