#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

function check {

  check_ntp=$(timedatectl show | grep 'NTP=yes')

  if [ -z $check_ntp ]; then

    message="\nTiene DESACTIVADA la sincronización con su servidor NTP, ¿Desea activarla?"

  else
      
    message="\nTiene ACTIVADO la sincronización con su servidor NTP, ¿Desea desactivarla?"

  fi

}

check

dialog --stdout --title "$title" --yesno "$message" 0 0

#if [ $? -eq 0 ]; then

   

#fi
