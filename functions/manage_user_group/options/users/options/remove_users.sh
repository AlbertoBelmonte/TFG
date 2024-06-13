#!/bin/bash

title="Administración del servidor $(hostname)"
message="\nSeleccione el usuario/s que desea eliminar del sistema"

path_r_users=$(mktemp)

# Obtención de TODOS los usuarios del sistema y ordenarlos según ID de menos a mayor

awk -F: '{print $3 ":" $1}' /etc/passwd | sort -n | awk -F: '{print $2 " " $1}' > $path_r_users
  
users=($(awk '{print $1}' $path_r_users))
ids=($(awk '{print $2}' $path_r_users))

# Almacenamiento de los usuarios con su respectiva ID en una variable

chose=()

for ((i=0; i<${#users[@]}; i++)); do

  chose+=("${users[$i]}" "${ids[$i]}" "")

done

selected_user=()
selected_user=($(dialog --stdout --title "$title" --checklist "$message" 0 0 0 "${chose[@]}"))

selec_system_user=()

for user in "${selected_user[@]}"; do

  id=$(id -u $user)

  if [[ $id -lt 1000 ]] ;then

    selec_system_user+=("$user")

  fi

done
  
  if [ ${#selec_system_user[@]} -eq 0 ];then
  
    message="\nVoy a eliminar los siguientes usuarios:\n\n- '${selected_user[@]}'\n\n¿Está seguro que desea borrarlos?, voy a eliminar tanto al usuario, como el HOME de dicho usuario/s."
  
  else
  
    message="\nVoy a eliminar los siguientes usuarios:\n\n- '${selected_user[@]}'\n\nDe los cuales los siguientes usuarios son de sistema:\n\n- '${selec_system_user[@]}'\n\n¿Está seguro que también desea también eliminarlos?"
  
  fi
  
  dialog --stdout --title "$title" --yesno "$message" 0 0

  error=()
  
  if [ $? -eq 0 ]; then
  
    for user in "${selected_user[@]}"; do
  
      userdel -rf $user

      if [[ $? -ne 0 ]]; then

        error_user=($user)

      fi
  
    done

    if [[ ${error_user[@]} -eq 0 ]]; then
  
      message="\nLos usuarios '${selected_user[@]}' han sido eliminados del sistema"
    

    else

      message="\nLos usuarios '${selected_user[@]}' han sido eliminados del sistema, pero los usuarios ${error_user[@]} no se han podido eliminar, revise el estado de los usuarios"
    
    fi

    dialog --stdout --title "$title" --msgbox "$message" 0 0

  else

    exit
  
fi
