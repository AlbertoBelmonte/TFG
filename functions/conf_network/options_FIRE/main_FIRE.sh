#!/bin/bash

# Textos del menú

title="Administración del servidor $(hostname)"
message="\nEl menu seleccionado todavía está en desarrollo"
#options=(
#    "Modificar" "Modificar una tarjeta de red"
#    "Listar" "Lista las tarjetas de red"
#)

# Mostrar el menú

#choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

dialog --stdout --title "$title" --msgbox "$message" 0 0

# Procesar la opción seleccionada
#case $choice in
#    "Modificar")
#        ./functions/conf_network/options/modify_n.sh
#        ;;
#    "Listar")
#        ./functions/conf_network/options/list_n.sh
#        ;;
#    *)
#        echo "Ninguna opción seleccionada."
#        ;;
#esac
