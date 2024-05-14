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
    "2 Monitoreo sistema" "Ver que recursos del sistema se están consumiendo"
    "3 Gestión de la red y del firewall" "Cambiar la configuración TCP/IP de las tarjetas de red y modificar el firewall"
    "4 Gestión de usuarios y grupos locales" "Añadir y borrar usuarios y grupos del sistema"
    "5 Gestión de procesos" "Comprobar qué programas están en ejecución y cuántos recursos consumen"
    "6 Gestión de servicios" "Comprobar y/o hacer que X programa se inicie al cargar el Sistema Operativo"
    "7 Programar tareas" "Indicarle al sistema cuándo tiene que ejecutar ciertos scripts y/o programas"
    "8 Administrar discos" "Montar, desmontar y formatear unidades de almacenamiento"
    "9 Reiniciar equipo" "Reiniciará el equipo"
    "10 Apagar equipo" "Apagará por completo el equipo"
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

# Procesar la opción seleccionada
case $choice in
    "1 Configuración básica del equipo")
        ./functions/conf_pc/main.sh
        ;;
    "2 Monitoreo sistema")
        bashtop
        ;;
    "3 Gestión de la red y del firewall")
        ./functions/conf_network/main.sh
        ;;
    "4 Gestión de usuarios y grupos locales")
        ./functions/manage_user_group/main.sh
        ;;
    "5 Gestión de procesos")
        ./functions/manage_task/main.sh
        ;;
    "6 Gestión de servicios")
        ./functions/manage_service/main.sh
        ;;
    "7 Programar tareas")
        ./functions/manage_tasks/main.sh
        ;;
    "8 Administrar discos")
        ./functions/manage_disk/main.sh
        ;;
    "9 Reiniciar equipo")
        ./functions/power_pc/main.sh 
        ;;
    "10 Apagar equipo")
        ./functions/power_pc/main.sh --off
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
