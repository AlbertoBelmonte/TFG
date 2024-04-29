#!/bin/bash

export LANG="es_ES.UTF-8"

# Textos del menú
#
title="Administración del servidor $(hostname)"

# Comprobar si se ha elegido previamente la opción de apagar o reiniciar

if [ "$1" = "--off" ]; then

    message="¿Está seguro de que desea APAGAR el equipo?"

else

    message="¿Está seguro de que desea REINICIAR el equipo?"

fi

# Función para el temporizador de apagado/reinicio
#
function countdown {

    for i in {0..10}; do

        sleep 0.5
        echo "$((i * 10))"

    done

}

# Mostrar el menú

dialog --title "$title" --yesno "$message" 0 0

# Verificar la respuesta del usuario

if [ $? -eq 0 ]; then

    if [ "$1" = "--off" ]; then

        countdown | dialog --title "$title" --gauge "Apagando el sistema, presione CTRL+C para cancelar" 0 0 0 && poweroff

    else

        countdown | dialog --title "$title" --gauge "Reiniciando el sistema, presione CTRL+C para cancelar" 0 0 0 && reboot

    fi

else

    echo "Ejecute de nuevo ubunadm para volver al menú"

fi
