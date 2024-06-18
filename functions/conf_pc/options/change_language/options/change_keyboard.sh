#!/bin/bash

title="Administración del servidor $(hostname)"

# Comprobar distribución del teclado

keyboard=$(localectl status | grep 'Layout' | awk '{print $3}')

message="\nActualmente tiene la distrubución $keyboard ¿Desea cambiar la distribución del teclado?, en caso de estar conectado mediante SSH tendra que cambiar la configuración de su cliente SSH"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  dpkg-reconfigure keyboard-configuration && service keyboard-setup restart

else

  exit

fi
