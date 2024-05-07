#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

message="\n¿Quiere actualizar TODOS los paquetes instalados en el sistema?"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ] ;then

  path_output=$(mktemp)

  output=$(sudo apt upgrade 2>&1 | tee $path_output)
  
  if [ $? -eq 0 ] ; then
  
    dialog --stdout --title "$title" --msgbox "\nLos paquetes se han actualizado correctamente." 0 0

  else
  
    exit_code=$(tail $path_output)
    dialog --stdout --title "$title" --msgbox "\nError al actualizar los paquetes. Este es el error\n\n$exit_code" 0 0

  fi

  else
  
    message="\nIndique que paquete o paquetes instalados en el sistema desea actualizar. Trate de dejar un espacio por cada paquete\n\nEjemplo: ssh firefox bind9"

    packages=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

    if sudo apt install --only-upgrade $packages -y; then
      
      dialog --stdout --title "$title" --msgbox "\nLos paquetes '$packages', se han actualizado correctamente." 0 0

    else
      
      exit_code=$(tail $path_output)
      dialog --stdout --title "$title" --msgbox "\nError al actualizar los paquetes '$packages'. Este es el error\n\n$exit_code" 0 0

    fi

fi
