#!/bin/bash

title="Administración del servidor $(hostname)"

message="\nEn este menu podrá realizar configuraciones básicas del equipo, como cambiar de nombre al equipo, cambiar el idioma del sistema, modificar la fecha"

options=(
    "1 Monitoreo del sistema" "Comprobar los recursos del sistema"
    "2 Comprobar temperaturas y consumo" "Comprobar tanto temperaturas y consumo de energia de los componentes del sistema"
    "3 Logs" "Comprobar los logs del sistema"

  )

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
      "1 Monitoreo del sistema")
          bashtop
          select_option
          ;;
      "2 Comprobar temperaturas y consumo")
          ./functions/monitor/options/temp_volt.sh
          select_option
          ;;
      "3 Logs")
          ./functions/monitor/options/logs.sh
          select_option
          ;;
      *)
          exit
          ;;
  esac

done
