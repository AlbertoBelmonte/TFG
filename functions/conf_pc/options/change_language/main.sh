#!/bin/bash

# Textos del menú
title="Administración del servidor $(hostname)"

message="Este menu permite cambiar el idioma del teclado y del sistema"

options=(
    "1 Cambiar el idioma del teclado" "Cambia el idioma del teclado"
    "2 Cambiar el idioma del sistema" "Cambia el idioma del sistema por completo"
)

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
  
    "1 Cambiar el idioma del teclado")
      ./functions/conf_pc/options/change_language/options/prueba.sh
      ./functions/conf_pc/options/change_language/options/change_keyboard.sh
      select_option
      ;;
      
    "2 Cambiar el idioma del sistema")
      ./functions/conf_pc/options/change_language/options/change_system.sh
      select_option
      ;;
      
    *)
      exit
      ;;

  esac

done
