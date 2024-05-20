#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

# Textos del menú
title="Administración del servidor $(hostname)"

message="\nEste menu permite actualizar tantos los repositorios como el sistema, y instalar y desinstalar paquetes"

options=(
    "1 Actualizar repositorios" ""
    "2 Actualizar paquetes" ""
    "3 Instalar paquetes" ""
    "4 Eliminar paquetes" ""
)

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Exit" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# procesar la opción seleccionada

while true; do

  case $choice in

    "1 Actualizar repositorios")
      ./functions/conf_pc/options/options_apt/options/update_repo.sh
      select_option
      ;;

    "2 Actualizar paquetes")
      ./functions/conf_pc/options/options_apt/options/upgrade_packages.sh
      select_option
      ;;

    "3 Instalar paquetes")
      ./functions/conf_pc/options/options_apt/options/install_package.sh
      select_option
      ;;

    "4 Eliminar paquetes")
      ./functions/conf_pc/options/options_apt/options/remove_package.sh
      select_option
      ;;

    *)
      exit
        ;;
esac
