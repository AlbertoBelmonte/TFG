#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

# Explicación menu 

message="\nEste menú esta destinado a tareas básicas del servidor, como cambiar el idioma, administrar los repositorios, cambiar el nombre del equipo..."

title="Administración del servidor $(hostname)"
message=""
options=(
    "1 Administrar repositorios" "instalar, actualizar y borrar repositorios"
    "2 Modificar fecha" "Cambiar la hora del sistema"
    "3 Cambiar idioma" "Cambiar el idioma del sistema y del teclado"
    "4 Cambiar nombre PC" "Cambiar el nombre del equipo"
    "5 Caracteristicas del sistema" "Ver que CPU tiene el equipo, la RAM, NIC'S..."
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

# Procesar la opción seleccionada
case $choice in
    "1 Administrar repositorios")
        ./functions/conf_pc/options/options_apt/main.sh
        ;;
    "2 Modificar fecha")
        ./functions/conf_pc/options/change_time/main.sh
        ;;
    "3 Cambiar idioma")
        ./functions/conf_pc/options/change_language/main.sh
        ;;
    "4 Cambiar nombre PC")
        ./functions/conf_pc/options/change_pcname/main.sh
        ;;
    "5 Caracteristicas del sistema")
        ./functions/conf_pc/options/check_specs/main.sh
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
