#!/bin/bash

TERM=ansi

function users {

  message="Seleccione el usuario"

  # Array nombre de usuarios con sus ID's
  
  users=($(awk -F: '{print $1}' /etc/passwd))
  id_users=($(awk -F: '{print $3}' /etc/passwd))

  # Array multidimensional (un diccionario) para almacenar el nombre de los usuarios con sus id
  
  declare -A rough_users
  
  for ((i=0; i<${#users[@]}; i++)); do
  
    rough_users[${users[$i]}]=${id_users[$i]}
  
  done

  # Menu para seleccionar al usuario

  chose=()

  for user in "${!rough_users[@]}"; do

    chose+=("$user" "${rough_users[$user]}")

  done

  user_selected=$(whiptail --title "$title" --menu "$message" 0 0 0 "${chose[@]}" 3>&1 1>&2 2>&3)

}

title="Administración del servidor $(hostname)"
message="¿Quién/es seran los involucrados en la tarea?, ¿un usuario o un grupo?"

choice=$(whiptail --title "$title" --yesno "$message" 0 0 --no-button "Grupo" --yes-button "Usuario" 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then

  users

else

  echo "Ejecute de nuevo ubunadm para volver al menu"

fi
