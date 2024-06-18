#!/bin/bash
  
title="Administración del servidor $(hostname)"

# Obtener la lista de discos

disks_info=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E 'disk|part')

# Array para almacenar las opciones de dialog

options=()

while read -r line; do

    disk_name=$(echo $line | awk '{print $1}')
    disk_info=$(echo $line | awk '{print $2, $3, $4}')

    options+=("$disk_name" "$disk_info")

done <<< "$disks_info"

# Mostrar el menú usando dialog

message="\nListado de discos con sus particiones del sistema, para más modificarlo seleccione un disco o partición."
choice=$(dialog --title "$title" --menu "$message" 0 0 0 "${options[@]}" 2>&1 >/dev/tty)

# Mostrar la información del disco seleccionado

if [ -n "$choice" ]; then

  cfdisk "/dev/$choice"

fi
