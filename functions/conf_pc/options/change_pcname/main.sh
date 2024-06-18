#!/bin/bash

title="Administración del servidor $(hostname)"
message="\nActualmente su equipo se llama '$(hostname)' ¿Desea cambiar el nombre del equipo?"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  message="\n¿Qué nombre desea ponerle al equipo?, para aplicarlo tendré que reiniciar el equipo"
  pcname=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

  if [ $? -eq 0 ]; then

      dialog --stdout --title "$title" --yesno "\nHa puesto '$pcname', ¿Está seguro de que el equipo se llame así?" 0 0

      if [ $? -eq 0 ]; then

        echo $pcname > /etc/hostname && ./functions/power_pc/main.sh
        break

      else 

        exit

      fi

    fi

else

  exit

fi
