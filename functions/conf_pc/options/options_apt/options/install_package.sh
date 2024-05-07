#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

# Textos del menú
title="Administración del servidor $(hostname)"

message="\n¿Que paquete o paquetes desea instalar? En caso de querer instalar más de un paquete, separelos por espacios blancos.\n\n Ejemplo: ssh firefox bind9"

# Mostrar el menú NANO NEOFETCH

ins_packages=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

if sudo apt install $ins_packages -y ;then

  message="\nLos paquetes '$ins_packages' se han instalado"
  
  dialog --stdout --title "$title" --msgbox "$message" 0 0

fi
