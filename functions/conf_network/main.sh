#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

# Explicación herramienta

message="\nEste menú esta destinado a la configuración de tarjetas de red y del firewall, para la configuración de las tarjetas de red se empleará la herramienta Netplan y para el firewall se empleará la herramienta ufw.\n\nNetplan es una herramienta de sistemas UNIX/LINUX que nos permite configurar las tarjetas de red mediante .yml"

alert=$(dialog --stdout --title "$title" --msgbox "$message" 0 0)

# Textos del menú

title="Administración del servidor $(hostname)"
message="Seleccione que desea configurar"
options=(
    "Configurar NIC" "Menu para modificar la tarjeta de red"
    "Configurar Firewall" "Menu para modificar las reglas del firewall"
)

# Mostrar el menú

function select_option {

  choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

}

select_option

# procesar la opción seleccionada

while true; do

  case $choice in
      "Configurar NIC")
          ./functions/conf_network/options_NIC/main_NIC.sh
          select_option
          ;;
      "Configurar Firewall")
          ./functions/conf_network/options_FIRE/main_FIRE.sh
          select_option
          ;;
      *)
        exit
          ;;
  esac

done
