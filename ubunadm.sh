#!/bin/bash

# establecer la codificación
export lang="es_es.utf-8"

# comprobación de la identidad del usuario
if [ "$(whoami)" != "root" ]; then

    title="administración del servidor $(hostname)"
    message="está ingresando como $(whoami), este script debe ejecutarse con el usuario root o con sudo.

con root --> 'su -'
con sudo --> 'sudo ./ubunadm.sh'"

    dialog --title "$title" --msgbox "$message" 0 0

    exit

fi

# textos del menú
title="administración del servidor $(hostname)"

message="este script sirve para administrar sistemas linux, en concreto la distribución ubuntu. si tiene alguna duda, ejecute en una terminal el comando '$0 -h'."

options=(
    "1 configuración básica del equipo" "Cambiar de nombre al equipo, actualizar repositorios..."
    "2 monitoreo sistema" "Gestionar y comprobar qué programas están en ejecución y cuántos recursos consumen"
    "3 gestión de la red y del firewall" "Cambiar la configuración tcp/ip de las tarjetas de red y modificar el firewall"
    "4 gestión de usuarios y grupos locales" "Añadir y borrar usuarios y grupos del sistema"
    "5 gestión de servicios" "Comprobar y/o hacer que x programa se inicie al cargar el sistema operativo"
    "6 programar tareas" "Indicarle al sistema cuándo tiene que ejecutar ciertos scripts y/o programas"
    "7 administrar discos" "Montar, desmontar y formatear unidades de almacenamiento"
    "8 reiniciar equipo" "Reiniciará el equipo"
    "9 apagar equipo" "Apagará por completo el equipo"
)

# mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Exit" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# procesar la opción seleccionada

while true; do

case $choice in

    "1 configuración básica del equipo")
        ./functions/conf_pc/main.sh 
        select_option
        ;;
    "2 monitoreo sistema")
        bashtop
        select_option
        ;;
    "3 gestión de la red y del firewall")
        ./functions/conf_network/main.sh
        select_option
        ;;
    "4 gestión de usuarios y grupos locales")
        ./functions/manage_user_group/main.sh
        select_option
        ;;
    "5 gestión de servicios")
        ./functions/manage_service/main.sh
        select_option
        ;;
    "6 programar tareas")
        ./functions/manage_tasks/main.sh
        select_option
        ;;
    "7 administrar discos")
        ./functions/manage_disk/main.sh
        select_option
        ;;
    "8 reiniciar equipo")
        ./functions/power_pc/main.sh 
        select_option
        ;;
    "9 apagar equipo")
        ./functions/power_pc/main.sh --off
        select_option
        ;;
    *)
      exit
      ;;

esac

done
