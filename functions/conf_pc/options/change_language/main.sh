#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

# Textos del menú
title="Administración del servidor $(hostname)"

message="Este menu permite cambiar el idioma del teclado y del sistema"

options=(
    "1 Cambiar el idioma del teclado" "Cambia el idioma del teclado"
    "2 Cambiar el idioma del sistema" "Cambia el idioma del sistema por completo"
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

# Procesar la opción seleccionada
case $choice in

    "1 Cambiar el idioma del teclado")
        ./functions/conf_pc/options/change_language/options/change_keyboard.sh
        ;;
    "2 Cambiar el idioma del sistema")
        ./functions/conf_pc/options/change_language/options/change_system.sh
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
