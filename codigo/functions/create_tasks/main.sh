#!/bin/bash

TERM=ansi

title="Administración del servidor $(hostname)"
message="Para programar las tareas empleo el comando 'cron'"
options=(

  "Crear" "Para crear una tarea cron"
  "Modificar" "Para modificar una tarea cron"
  "Borrar" "Para Borrar una tarea cron"

  )

choice=$(whiptail --title "$title" --menu "$message" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3)

case $choice in

    "Crear")
        ./functions/create_tasks/options/create_c.sh
        ;;
    "Modificar")
        ./functions/create_tasks/options/modify_c.sh
        ;;
    "Borrar")
        ./functions/create_tasks/options/delete_c.sh
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac
