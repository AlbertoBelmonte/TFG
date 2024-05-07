#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

# Textos del menú
title="Administración del servidor $(hostname)"

message="\n¿Quiere actualizar los repositorios?"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ] ;then

  if sudo apt update -y; then
  
    dialog --stdout --title "$title" --msgbox "\nLos repositorios se han actualizado correctamente." 0 0

  else
  
    exit_code=$?
    dialog --stdout --title "$title" --msgbox "\nError al actualizar los repositorios.\n\nCódigo de salida: $exit_code" 0 0

  fi

fi
