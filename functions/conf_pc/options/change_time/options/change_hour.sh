#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

message="\nVa ha cambiar la hora a mano, ¿Está seguro de ello?, ahora mismo tiene la hora $(date +%T)"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [[ $? -eq 0 ]]; then

  time=$(dialog --stdout --title "$title" --timebox "\nIntroduzca la hora" 0 0)

  sudo date +%T -s "$time"

else

  exit

fi
