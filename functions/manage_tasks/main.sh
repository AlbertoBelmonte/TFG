#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

# Explicación herramienta

message="\nEste menú esta destinado a la creación de tareas con la herramienta CRON.\n\nCRON es una herramienta de sistemas UNIX/LINUX que nos permite crear tareas para que se ejecuten en 2º plano cada x tiempo al usuario que queramos, pero para ello tenemos que indicarle que comando o script ha de ejecutar (si es más de un comando es recomendable crear un script en base a esos comandos)"

alert=$(dialog --stdout --title "$title" --msgbox "$message" 0 0)

# Textos del menú

title="Administración del servidor $(hostname)"
message="Para programar tareas, se emplea el comando 'cron'"
options=(
    "Crear" "Crear una nueva tarea cron"
    "Modificar" "Modificar una tarea cron existente"
    "Borrar" "Borrar una tarea cron existente"
    "Listar" "Lista las tarea cron existentes"
)

function select_option {

  choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# Procesar la opción seleccionada

while true; do

  case $choice in
    
    "Crear")
      ./functions/manage_tasks/options/create_c.sh
      select_option
      ;;

    "Modificar")
      ./functions/manage_tasks/options/modify_c.sh
      select_option
      ;;

    "Borrar")
      ./functions/manage_tasks/options/delete_c.sh
      select_option
      ;;

    "Listar")
      ./functions/manage_tasks/options/list_c.sh
      select_option
      ;;

    *)
      exit
      ;;

  esac

done
