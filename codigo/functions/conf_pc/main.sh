#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

# Explicación herramienta

message="\nEste menú esta destinado a tareas básica de administración del servidor, como cambiar el idioma, administrar los repositorios..."

alert=$(dialog --stdout --title "$title" --msgbox "$message" 0 0)

# Textos del menú

title="Administración del servidor $(hostname)"
message="Para programar tareas, se emplea el comando 'cron'"
options=(
    "1 Administrar repositorios" "instalar, actualizar y borrar repositorios"
    "2 Modificar fecha" "Cambiar la hora del sistema"
    "3 Cambiar idioma" "Cambiar el idioma del sistema y del teclado"
    "4 Cambiar nombre PC" "Cambiar el nombre del equipo"
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

# Procesar la opción seleccionada
case $choice in
    "1 Administrar repositorios")
        ./functions/conf_pc/options/options_apt/main.sh
        ;;
    "2 Modificar fecha")
        ./functions/conf_pc/options/change_date/main.sh
        ;;
    "3 Cambiar idioma")
        ./functions/conf_pc/options/change_language/main.sh
        ;;
    "4 Cambiar nombre PC")
        ./functions/conf_pc/options/change_pcname/main.sh
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
