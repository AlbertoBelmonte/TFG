#!/bin/bash

title="Administración del servidor $(hostname)"
message="\nListado de usuarios del sistema"

path_r_users=$(mktemp)

# Obtención de TODOS los usuarios del sistema y ordenarlos según ID de menos a mayor
#
awk -F: '{print $3 ":" $1}' /etc/passwd | sort -n | awk -F: '{print $2 " " $1}' > "$path_r_users"

users=($(awk '{print $1}' "$path_r_users"))
ids=($(awk '{print $2}' "$path_r_users"))

# Almacenamiento de los usuarios con su respectiva ID en una variable

chose=()

for ((i=0; i<${#users[@]}; i++)); do

  chose+=("${users[$i]}" "${ids[$i]}")

done

selected_user=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${chose[@]}")

if [[ $? -eq 0 ]]; then
  
  # Obtención de la shell del usuario seleccionado
  
  shell=$(getent passwd "$selected_user" | cut -d: -f7)
  
  # Obtención de los grupos del usuario seleccionado

  groups=$(id -nG "$selected_user")
  
  # Obtención del comentario del usuario seleccionado
  
  comment=$(getent passwd "$selected_user" | cut -d: -f5)
  
  temp=$(mktemp)
  
  dialog --title "$title" --form "$message" 0 0 0 \
    "Usuario:"          1 1 "$selected_user" 1 18 50 0 \
    "Shell:"            2 1 "$shell" 2 18 50 0 \
    "Grupos:"           3 1 "$groups" 3 18 50 0 \
    "Comentario:"       4 1 "$comment" 4 18 50 0 \
    "Contraseña:"       5 1 "" 5 18 50 0  2> "$temp"
  
  user_data=()
  
  while IFS= read -r line; do

    user_data+=("$line")
  
  done < "$temp"
  
  rm -f "$temp"

  if [[ ${#user_data[@]} -ne 0 ]]; then

    message="\nEstá seguro que desea asignar la siguiente configuración al usuario el usuario con los siguientes datos:\n\nUsuario: ${user_data[0]}\nShell: ${user_data[1]}\nGrupos: ${user_data[2]}\nComentario: ${user_data[3]}\nContraseña: ${user_data[4]}"

    dialog --stdout --title "$title" --yesno "$message" 0 0

    if [[ $? -eq 0 ]]; then

      # Cambiar nombre

      if [[ "${user_data[0]}" != "$selected_user" ]]; then

        sudo usermod -l "${user_data[0]}" "$selected_user"

      fi

      # Cambiar shell
    
      if [[ "${user_data[1]}" != "$shell" ]]; then

        sudo chsh -s "${user_data[1]}" "$selected_user"

      fi

      # Cambiar grupos
      
      if [[ "${user_data[2]}" != "$groups" ]]; then

        group=$()

        sudo usermod -G "$(echo $groups | tr ' ' ',')" "$selected_user"
        sudo usermod -aG "$(echo ${user_data[2]} | tr ' ' ',')" "$selected_user"

      fi

      # Cambiar comentario

      if [[ "${user_data[3]}" != "$comment" ]]; then

        sudo usermod -c "${user_data[3]}" "$selected_user"

      fi

      # Cambiar contraseña
      
      if [[ -n "${user_data[4]}" ]]; then

        echo "${user_data[0]}:${user_data[4]}" | sudo chpasswd

      fi

    else

      exit

    fi

  else

    exit
  
  fi
  
else

  exit

fi

# Cleanup
rm -f "$path_r_users"