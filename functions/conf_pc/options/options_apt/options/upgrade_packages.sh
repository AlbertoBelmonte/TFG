#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

message="\n¿Quiere actualizar TODOS los paquetes instalados en el sistema? en caso de querer solo actualizar x paquetes, seleccione no"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ] ;then

  if sudo apt upgrade -y ; then
  
    dialog --stdout --title "$title" --msgbox "\nLos paquetes se han actualizado correctamente." 0 0

    else
  
      exit_code=$?
      dialog --stdout --title "$title" --msgbox "\nError al actualizar los paquetes. Este es el error\n\n$exit_code" 0 0

  fi

  else
  
    message="\nIndique que paquete o paquetes instalados en el sistema desea actualizar. Trate de dejar un espacio por cada paquete\n\nEjemplo: ssh firefox bind9"

    packages=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

    if [ -z $packages]; then

      while true; do

        dialog --stdout --title "$title" --yesno "\nNo ha introducido ningún nombre, ¿Desea actualizar algun paquete?" 0 0

        if [ $? -eq 0 ]; then

            break

          else

            exit

        fi
        
      done

    else

      if sudo apt install --only-upgrade $packages -y; then
      
        dialog --stdout --title "$title" --msgbox "\nLos paquetes '$packages', se han actualizado correctamente." 0 0

      else
      
        exit_code=$(tail $path_output)
        dialog --stdout --title "$title" --msgbox "\nError al actualizar los paquetes '$packages'. Este es el error\n\n$exit_code" 0 0
      
      fi

    fi

fi
