#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"


message="\nAhora mismo su equipo tiene la siguiente fecha y hora:\n\n"

data_time=()

# Transforma la entrada de timedatectl en un array con mapfile, sin espacios al principio con awk

mapfile -t data_time < <(timedatectl | awk '{$1=$1};1')

for line in "${data_time[@]}"; do

  message+="$line\n"

done

message+="\n¿Desea cambiar la hora y/o fecha del equipo?"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

message="Este menu permite modificar la hora, fecha y region, para ello emplea la herramienta 'timedatectl'."

options=(
    "1 Cambiar hora" "Cambiar la hora manualmente"
    "2 Cambiar fecha" "Cambiar la fecha manualmente"
    "3 Cambiar region" "Cambiar la region manualmente"
    "4 Sincronizar hora con servidor NTP " "Activar/Desactivar sincronización de la hora con un servidor NTP"
)

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${options[@]}")

case $choice in
    "1 Cambiar hora")
        ./functions/conf_pc/options/change_time/option/change_hour.sh
        ;;
    "2 Cambiar fecha")
        ./functions/conf_pc/options/change_time/option/change_date.sh
        ;;
    "3 Cambiar region")
        ./functions/conf_pc/options/change_time/option/change_region.sh
        ;;
    "4 Sincronizar hora NTP")
        ./functions/conf_pc/options/change_time/option/switch_ntp.sh
        ;;
    *)
        echo "Ninguna opción seleccionada."
        ;;
esac

fi
