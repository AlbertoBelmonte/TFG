#!/bin/bash

title="Administración del servidor $(hostname)"

declare -a not_created_users

function create_user {

    # 0=user | 1=shell | 2=groups | 3=comment | 4=password
  
    #Si no se introduce shell se pone una default

    if [[ -z ${user_data[1]} ]];then
  
      shell="/bin/false"
  
    fi

    if [[ -z ${user_data[2]} ]];then
  
      sudo useradd ${user_data[0]} -m -s "${user_data[1]}" -c "${user_data[3]}"

    else

      sudo useradd ${user_data[0]} -m -s "${user_data[1]}" -G "${user_data[2]}" -c "${user_data[3]}"

    fi

    # Comprobación si se ha creado el usuario correctamente, en caso de que no, guarda el nombre en un array

    if [ $? -eq 0 ]; then

      if [ -n $7 ]; then
      
        echo "${user_data[0]}:${user_data[4]}" | sudo chpasswd

      fi

      else

        not_created_users+=("${user_data[0]}")
          
    fi 

}

function multiple_users {

  message="\nIntroduzca la ruta donde está el archivo .csv\n\nEl archivo .csv ha de tener el siguiente formato:\n\nuser;shell;groups;comment;password\n\nEn caso de no tener claro algun campo o directamente no quieres asignarle un valor, dejalo en blanco. La contraseña ha de estar en texto plano. Asegurate de que los grupos son existentes y que esten separados por espacios --> rrhh prueba1 android\n\n ejemplo csv:\n usuario;/bin/bash;grupo1 grupo2;esto es un comentario;1234"

  dialog --stdout --title "$title" --msgbox "$message" 0 0
  
  csv_path=$(dialog --stdout --title "$title" --fselect /home/ 0 0 0)
  
  while IFS=";" read -r user shell groups comment password; do

    user_data=()
    user_data=("$user" "$shell" "$groups" "$comment" "$password")

    create_user

  done < $csv_path

}

function one_user {

  message="\nEn caso de no tener claro algun campo o directamente no quieres asignarle un valor, dejalo en blanco. La contraseña ha de estar en texto plano. Asegurate de que los grupos son existentes y que esten separados por espacios --> rrhh prueba1 android"

  temp=$(mktemp)

  dialog --title "$title" --form "$message" 0 0 0 \
                "Usuario:"          1 1 "" 1 18 50 0 \
                "Shell:"            2 1 "/bin/bash" 2 18 50 0 \
                "Grupos:"           3 1 "" 3 18 50 0 \
                "Comentario:"       4 1 "" 4 18 50 0 \
                "Contraseña:"       5 1 "" 5 18 50 0 2> $temp

  user_data=()

  while IFS= read -r line; do
  
    user_data+=("$line")
  
  done < $temp

  rm -f $temp

  message="\nEstá seguro que desea crear el usuario con los siguientes datos:\n\nUsuario: ${user_data[0]}\nShell: ${user_data[1]}\nGrupos: ${user_data[2]}\nComentario: ${user_data[3]}\nContraseña: ${user_data[4]}"

  dialog --stdout --title "$title" --yesno "$message" 0 0

  if [[ $? -eq 0 ]]; then

    create_user 

  fi 

}

message="\nSeleccione si quiere crear un usuario invididual o multiples usuarios mediante un .csv"

options=(
    "1 Crear un usuario" "Mostrará un formulario para introducir los datos del usuario"
    "2 Crear usuarios con .csv" "Importará los datos de los usuarios desde un .csv"
)


choice=$(dialog --stdout --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}")

if [[ $choice == "1 Crear un usuario" ]]; then

  one_user

else

  multiple_users

fi

if [ ${#not_created_users[@]} -eq 0 ];then

  message="\nSe han creado todos los usuarios"

  else

  message="\nLos siguientes usuarios no han sido creados\n -${not_created_users[@]}"

fi

dialog --stdout --title "$title" --msgbox "$message" 0 0
