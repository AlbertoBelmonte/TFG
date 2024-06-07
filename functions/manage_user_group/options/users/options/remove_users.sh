#!/bin/bash

title="Administración del servidor $(hostname)"
message="\nSeleccione el usuario/s que desea eliminar del sistema"

path_r_users="/tmp/temp_users"

# Obtención de TODOS los usuarios del sistema y ordenarlos según ID de menos a mayor

awk -F: '{print $3 ":" $1}' /etc/passwd | sort -n | awk -F: '{print $2 " " $1}' > $path_r_users
  
users=($(awk '{print $1}' $path_r_users))
ids=($(awk '{print $2}' $path_r_users))

# Almacenamiento de los usuarios con su respectiva ID en una variable

chose=()
system_user=()

for ((i=0; i<${#users[@]}; i++)); do

  chose+=("${users[$i]}" "${ids[$i]}" "")

  if [ ${ids[$i]} -lt 1000 ];then
  
    system_user+=("${users[$i]}")
  
  fi

done

selected_user=()
selected_user=($(dialog --stdout --title "$title" --checklist "$message" 0 0 0 "${chose[@]}"))

selec_system_user=()

for user in "${selected_user[@]}"; do

  for sys_user in "${system_user[@]}"; do
 
    if [[ $user == $sys_user ]] ;then

      selec_system_user+=("$user")

    fi

  done

done

check_sys_user=0

if [ ${#selec_system_user[@]} -eq 0 ];then

  message="\nVoy a eliminar los siguientes usuarios: '${selected_user[@]}'\n¿Está seguro que desea borrarlos?, voy a eliminar tanto al usuario, como el HOME de dicho usuario/s."

else

  message="\nVoy a eliminar los siguientes usuarios: '${selected_user[@]}'\nDe los cuales '${selec_system_user[@]}' son usuarios de sistema, ¿Está seguro que también desea también eliminarlos?"

fi

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  for user in "${#selected_user[@]}"; do

    userdel -rf $user

  done

  message="\nLos usuarios '${selected_user[@]}' han sido eliminados del sistema"
  dialog --stdout --title "$title" --msgbox "$message" 0 0

fi
