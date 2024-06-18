#!/bin/bash

title="Administración del servidor $(hostname)"

# Obtener todos los usuarios del sistema

users=$(cut -d: -f1 /etc/passwd)
tempfile=$(mktemp)

# Iterar sobre cada usuario y obtener sus tareas cron
for user in $users; do

    user_crontab=$(crontab -l -u $user 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$')

    if [[ -n "$user_crontab" ]]; then

        found_cron_jobs=true
        echo "---------------------------------------------------------" >> $tempfile
        echo -e "\nTareas Cron para el usuario: $user" >> $tempfile
        echo "---------------------------------------------------------" >> $tempfile
        echo "$user_crontab" >> $tempfile

    fi

done

# Comprobar si se encontraron tareas cron

if $found_cron_jobs; then

    # Mostrar las tareas cron en un cuadro de diálogo
    dialog --title "$title" --textbox "$tempfile" 0 0

else

    dialog --title "$title" --msgbox "\nNo se encontraron tareas cron para ningún usuario." 0 0

fi

rm -f $tempfile
