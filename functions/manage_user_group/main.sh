#!/bin/bash

title="Administración del servidor $(hostname)"

message="\nEn este menú podrá administrar el apartado de usuarios y grupos del sistema, tanto usuarios/grupos de sistema como usuarios de personas"

options=(
    "1 Usuarios" "Administrar los usuarios del sistema"
    "2 Grupos" "Administrar los grupos del sistema"
)

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
      "1 Usuarios")
          ./functions/manage_user_group/options/users/main.sh
          select_option
          ;;
      "2 Grupos")
          ./functions/manage_user_group/options/groups/main.sh
          select_option
          ;;
      *)
          exit
          ;;
  esac

done
