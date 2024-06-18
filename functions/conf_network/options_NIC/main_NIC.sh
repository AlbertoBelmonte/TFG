#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

# Explicación herramienta

message="\nEste menú esta destinado a la configuración de tarjetas de red, para su configuración se empleará la herramienta Netplan.\n\nNetplan es una herramienta de sistemas UNIX/LINUX que nos permite configurar las tarjetas de red mediante .yml"

alert=$(dialog --stdout --title "$title" --cancel-label "Atras"--msgbox "$message" 0 0)

# Textos del menú

title="Administración del servidor $(hostname)"
message="Para configurar las tarjetas de red, se emplea el comando 'netplan'"
options=(
    "Modificar" "Modificar una tarjeta de red"
    "Listar" "Lista las tarjetas de red"
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

# Procesar la opción seleccionada
case $choice in
    "Modificar")
        ./functions/conf_network/options_NIC/options/modify_n.sh
        ;;
    "Listar")
        ./functions/conf_network/options_NIC/options/list_n.sh
        ;;
    *)
      exit
        ;;
esac
