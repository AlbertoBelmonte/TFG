#!/bin/bash

message="\nSeleccione el usuario"
path_r_users="/tmp/temp_users"

# Obtención de TODOS los usuarios del sistema y ordenarlos según ID de menos a mayor

awk -F: '{print $3 ":" $1}' /etc/passwd | sort -n | awk -F: '{print $2 " " $1}' > $path_r_users
  
users=($(awk '{print $1}' $path_r_users))
ids=($(awk '{print $2}' $path_r_users))

# Almacenamiento de los usuarios con su respectiva ID en una variable

chose=()

for ((i=0; i<${#users[@]}; i++)); do

  chose+=("${users[$i]}" "${ids[$i]}")

done

selected_user=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${chose[@]}")
