#!/bin/bash

# Para añadir caracteres especiales como las tildes y la ñ

TERM=ansi

# Textos del menu

title="Administración del servidor $(hostname)"

# Compruebo si el ha elegido previamente la opción de apagar o reiniciar

if [ "$1" = "--off" ]; then

  message="¿Está seguro que desea APAGAR el equipo?"

else 

  message="¿Está seguro que desea REINICIAR el equipo?"

fi

# Cuenta atras para apagado/reiniciado

function countdown {

  for i in {0..100..10}; do
  
    sleep 0.5
    export TERM=linux
    echo $i | whiptail --title "$title" --gauge "$status el sistema, presione CTRL+C para cancelar" 0 0 0
  
  done

}

# Mostrar el menú

choice=$(whiptail --title "$title" --yesno "$message" 0 0 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then

  if [ "$1" = "--off" ]; then

    status="Apagando"
    countdown && poweroff
     
  else

    status="Reiniciando"
    countdown && reboot

  fi

else

  echo "Ejecute de nuevo ubunadm para volver al menu"

fi
