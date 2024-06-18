#!/bin/bash

# comprobación de la identidad del usuario
if [ "$(whoami)" != "root" ]; then

    title="Administración del servidor $(hostname)"
    message="\nEstá ingresando como $(whoami), este script debe ejecutarse con el usuario root o con sudo.

con root --> 'su -'
con sudo --> 'sudo ./ubunadm.sh'"

    dialog --title "$title" --msgbox "$message" 0 0

    exit

fi

# textos del menú
title="Administración del servidor $(hostname)"

message="\nEste script sirve para administrar sistemas linux, en concreto la distribución ubuntu. si tiene alguna duda, ejecute en una terminal el comando '$0 -h'."

options=(
    "1 Configuración básica del equipo" "Cambiar de nombre al equipo, actualizar repositorios..."
    "2 Monitoreo sistema" "Gestionar y comprobar qué programas están en ejecución y cuántos recursos consumen"
    "3 Gestión de la red y del firewall" "Cambiar la configuración tcp/ip de las tarjetas de red y modificar el firewall"
    "4 Gestión de usuarios y grupos locales" "Añadir y borrar usuarios y grupos del sistema"
    "5 Gestión de servicios" "Comprobar y/o hacer que x programa se inicie al cargar el sistema operativo"
    "6 Programar tareas" "Indicarle al sistema cuándo tiene que ejecutar ciertos scripts y/o programas"
    "7 Administrar discos" "Montar, desmontar y formatear unidades de almacenamiento"
    "8 Reiniciar equipo" "Reiniciará el equipo"
    "9 Apagar equipo" "Apagará por completo el equipo"
)

# mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Salir" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# procesar la opción seleccionada

while true; do

case $choice in

    "1 Configuración básica del equipo")
        ./functions/conf_pc/main.sh 
        select_option
        ;;
    "2 Monitoreo sistema")
        ./functions/monitor/main.sh
        select_option
        ;;
    "3 Gestión de la red y del firewall")
        ./functions/conf_network/main.sh
        select_option
        ;;
    "4 Gestión de usuarios y grupos locales")
        ./functions/manage_user_group/main.sh
        select_option
        ;;
    "5 Gestión de servicios")
        ./functions/manage_service/main.sh
        select_option
        ;;
    "6 Programar tareas")
        ./functions/manage_tasks/main.sh
        select_option
        ;;
    "7 Administrar discos")
        ./functions/manage_disk/main.sh
        select_option
        ;;
    "8 Reiniciar equipo")
        ./functions/power_pc/main.sh 
        select_option
        ;;
    "9 Apagar equipo")
        ./functions/power_pc/main.sh --off
        select_option
        ;;
    *)
      exit
      ;;

esac

done
