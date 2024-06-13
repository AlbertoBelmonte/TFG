#!/bin/bash

title="Administración del servidor $(hostname)"

message="\nEn este menu podrá realizar configuraciones básicas del equipo, como cambiar de nombre al equipo, cambiar el idioma del sistema, modificar la fecha"

options=(
    "1 Administrar repositorios" "instalar, actualizar y borrar repositorios"
    "2 Modificar fecha" "Cambiar la hora del sistema"
    "3 Cambiar idioma" "Cambiar el idioma del sistema y del teclado"
    "4 Cambiar nombre PC" "Cambiar el nombre del equipo"
    "5 Caracteristicas del sistema" "Ver que CPU tiene el equipo, la RAM, NIC'S..."
)

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
      "1 Administrar repositorios")
          ./functions/conf_pc/options/options_apt/main.sh
          select_option
          ;;
      "2 Modificar fecha")
          ./functions/conf_pc/options/change_time/main.sh
          select_option
          ;;
      "3 Cambiar idioma")
          ./functions/conf_pc/options/change_language/main.sh
          select_option
          ;;
      "4 Cambiar nombre PC")
          ./functions/conf_pc/options/change_pcname/main.sh
          select_option
          ;;
      "5 Caracteristicas del sistema")
          ./functions/conf_pc/options/check_specs/main.sh
          select_option
          ;;
      *)
          exit
          ;;
  esac

done
