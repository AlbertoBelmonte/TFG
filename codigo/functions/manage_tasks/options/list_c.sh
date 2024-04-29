#!/bin/bash

TERM=ansi

title="Administración del servidor $(hostname)"
message="Para programar las tareas empleo el comando 'cron'"

choice=$(whiptail --title "$title" --menu "$message" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3)

# Creo un array que almacena el nombre del usuarios con sus respectivas ID's

users=$(awk -F: '{print $1}' /etc/passwd)
id_users=$(awk -F: '{print $3}' /etc/passwd)

# Declaro una array multidimensional (un diccionario) para almacenar el nombre de los usuarios con sus respectivas id

#declare -A rough_users
#
#for ((i=0; i<${#users[@]}; i++)); do
#
#  rough_users[${users[$i]}]=${id_users[$i]}
#
#done

# Separo los usuarios del sistema de los usuarios de los servicios

#for ((i=0; i<${#rough_users[@]}; i++)); do
#
#  if []; then
#  
#      
#  
#  fi
#
#done

#options=()
#
#for ((i=0; i<=${#rough_users[@]}; i++));do
#
#  options=+($rough_user[i])
#
#done
#
#name=$(whiptail --title "$title" --inputbox "$message" 0 0 3>&1 1>&2 2>&3)
