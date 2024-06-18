#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

# Explicación menu 

message="\nEn este menu podrá realizar interactuar los famosos deamon de linux/unix, podrá realizar las siguientes opciones:"

options=(
    "Listar" "Lista todos los servicios del sistema"
    "Activar/Desactivar" "Permite activar desactivar servicios"
    "Crear" "Crea servicios para el sistema"
    "Modificar" "Modifica los servicios seleccionados del sistema"
    "Eliminar" "Elimina los servicios seleccionados del sistema"
)

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
      "Listar")
          ./functions/manage_service/options/list_service.sh
          select_option
          ;;
      "Activar/Desactivar")
          ./functions/manage_service/options/act_des_service.sh 
          select_option
          ;;
      "Crear")
          ./functions/manage_service/options/create_services.sh
          select_option
          ;;
      "Modificar")
          ./functions/manage_service/options/modify_service.sh
          select_option
          ;;
      "Eliminar")
          ./functions/manage_service/options/delete_service.sh
          select_option
          ;;
      *)
          exit
          ;;
  esac

done
