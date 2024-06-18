#!/bin/bash

title="Administración de  Cron"

# Obtener todos los usuarios del sistema
users=$(cut -d: -f1 /etc/passwd)

# Crear una lista de usuarios con tareas cron
user_list=()

# Iterar sobre cada usuario y verificar si tienen tareas cron

for user in $users; do

    user_crontab=$(crontab -l -u $user 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$')

    if [[ -n "$user_crontab" ]]; then

        user_list+=("$user" "")

    fi

done

# Comprobar si se encontraron usuarios con tareas cron

if [ ${#user_list[@]} -eq 0 ]; then

    dialog --title "$title" --msgbox "\nNo se encontraron tareas cron para ningún usuario." 0 0
    exit

fi

# Seleccionar un usuario

selected_user=$(dialog --stdout --title "$title" --menu "Seleccione un usuario para administrar sus tareas cron:" 0 0 0 "${user_list[@]}")

if [[ -z "$selected_user" ]]; then

    exit

fi

# Obtener las tareas cron del usuario seleccionado

user_crontab=$(crontab -l -u $selected_user 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$')

# Crear opciones para el checklist

options=()
counter=1

while IFS= read -r line; do
    options+=("$counter" "$line" "off")
    ((counter++))
done <<< "$user_crontab"

# Mostrar el checklist para seleccionar tareas a eliminar

selected_tasks=$(dialog --stdout --title "$title" --checklist "Seleccione las tareas cron a eliminar:" 0 0 0 "${options[@]}")

if [[ -n "$selected_tasks" ]]; then

    # Convertir selected_tasks en un array

    IFS=" " read -r -a tasks_array <<< "$selected_tasks"
    
    # Crear una copia del crontab del usuario y eliminar las tareas seleccionadas
    
    updated_crontab=$(echo "$user_crontab")

    for task_index in "${tasks_array[@]}"; do

        task=$(echo "$user_crontab" | sed -n "${task_index}p")
        updated_crontab=$(echo "$updated_crontab" | grep -vF "$task")

    done

    # Actualizar el crontab del usuario

    echo "$updated_crontab" | crontab -u $selected_user -

    dialog --title "$title" --msgbox "\nTareas cron eliminadas con éxito." 0 0

else

    # Preguntar si desea eliminar todas las tareas

    dialog --stdout --title "$title" --yesno "\n¿Desea eliminar todas las tareas cron del usuario $selected_user?" 0 0

    if [[ $? -eq 0 ]]; then

      crontab -r -u $selected_user

      dialog --title "$title" --msgbox "\nTodas las tareas cron del usuario $selected_user han sido eliminadas." 0 0

    else
        
      exit

    fi
fi
