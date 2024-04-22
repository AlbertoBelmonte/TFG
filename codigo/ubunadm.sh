#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

# Comprobación de la identidad del usuario
if [ "$(whoami)" != "root" ]; then

    title="Administración del servidor $(hostname)"
    message="Está ingresando como $(whoami), este script debe ejecutarse con el usuario root o con sudo.

Con root --> 'su -'
Con sudo --> 'sudo ./ubunadm.sh'"

    dialog --title "$title" --msgbox "$message" 0 0

    exit

fi

# Textos del menú
title="Administración del servidor $(hostname)"

message="Este script sirve para administrar sistemas Linux, en concreto la distribución Ubuntu. Si tiene alguna duda, ejecute en una terminal el comando '$0 -h'."

options=(
    "1 Configuración básica del equipo" "Cambiar de nombre al equipo, actualizar repositorios..."
    "2 Gestión de la red y del firewall" "Cambiar la configuración TCP/IP de las tarjetas de red y modificar el firewall"
    "3 Gestión de usuarios y grupos locales" "Añadir y borrar usuarios y grupos del sistema"
    "4 Configuración de cuentas y contraseñas" "Cambiar contraseñas y asignar grupos a los usuarios del sistema"
    "5 Gestión de procesos" "Comprobar qué programas están en ejecución y cuántos recursos consumen"
    "6 Gestión de servicios" "Comprobar y/o hacer que X programa se inicie al cargar el Sistema Operativo"
    "7 Programar tareas" "Indicarle al sistema cuándo tiene que ejecutar ciertos scripts y/o programas"
    "8 Reiniciar equipo" "Reiniciará el equipo"
    "9 Apagar equipo" "Apagará por completo el equipo"
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

# Procesar la opción seleccionada
case $choice in
    "1 Configuración básica del equipo")
        ;;
    "2 Gestión de la red y del firewall")
        ;;
    "3 Gestión de usuarios y grupos locales")
        ;;
    "4 Configuración de cuentas y contraseñas")
        ;;
    "5 Gestión de procesos")
        ;;
    "6 Gestión de servicios")
        ;;
    "7 Programar tareas")
        ./functions/create_tasks/main.sh
        ;;
    "8 Reiniciar equipo")
        ./functions/power_pc/main.sh 
        ;;
    "9 Apagar equipo")
        ./functions/power_pc/main.sh --off
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
