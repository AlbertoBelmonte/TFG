#!/bin/bash

# Para añadir caracteres especiales como las tildes y la ñ
TERM=ansi

# Textos del menu

title="Administración del servidor $(hostname)"

message="
Este script sirve para administrar sistemas Linux, en concreto la distribución Ubuntu. Si tiene alguna duda, ejecute en una terminal el comando 'ubunadm -h'."

options=(
    "Configuración básica del equipo" "Cambiar de nombre al equipo, actualizar repositorios..."
    "Gestión de la red y del firewall" "Cambiar la configuración TCP/IP de las tarjetas de red y modificar el firewall"
    "Gestión de usuarios y grupos locales" "Añadir y borrar usuarios y grupos del sistema"
    "Configuración de cuentas y contraseñas" "Cambiar contraseñas y asignar grupos a los usuarios del sistema"
    "Gestión de procesos" "Comprobar qué programas están en ejecución y cuántos recursos consumen"
    "Gestión de servicios" "Comprobar y/o hacer que X programa se inicie al cargar el Sistema Operativo"
    "Programar tareas" "Indicarle al sistema cuándo tiene que ejecutar ciertos scripts y/o programas"
    "Reiniciar equipo" "Reiniciará el equipo"
    "Apagar equipo" "Apagará por completo el equipo"
)

# Mostrar el menú

choice=$(whiptail --title "$title" --menu "$message" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3)

# Procesar la opción seleccionada

case $choice in

    "Configuración básica del equipo")

        ;;
    "Gestión de la red y del firewall")

        ;;
    "Gestión de usuarios y grupos locales")

        ;;
    "Opciones de configuración de cuentas y contraseñas")

        ;;
    "Gestión de procesos")

        ;;
    "Gestión de servicios")

        ;;
    "Programar tareas")

        ;;
    "Reiniciar equipo")
        ./functions/power_pc/main.sh 
        ;;
    "Apagar equipo")
        ./functions/power_pc/main.sh --off
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
