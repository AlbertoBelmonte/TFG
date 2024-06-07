#!/bin/bash

title="Administración del servidor $(hostname)"

message="\nEn este menú podrá administrar el apartado de usuarios del sistema, tanto usuarios de sistema como usuarios clientes"

options=(
    "1 Crear usuarios" ""
    "2 Modificar usuarios" ""
    "3 Listar usuarios" ""
    "4 Borrar usuarios" ""
)

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
      "1 Crear usuarios")
          ./functions/manage_user_group/options/users/options/create_users.sh
          select_option
          ;;
      "2 Modificar usuarios")
          ./functions/manage_user_group/options/users/options/modify_users.sh
          select_option
          ;;
      "3 Listar usuarios")
          ./functions/manage_user_group/options/users/options/list_users.sh
          select_option
          ;;
      "4 Borrar usuarios")
          ./functions/manage_user_group/options/users/options/remove_users.sh
          select_option
          ;;
      *)
          exit
          ;;
  esac

done
