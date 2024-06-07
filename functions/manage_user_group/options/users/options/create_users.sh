#!/bin/bash

title="Administración del servidor $(hostname)\n"

declare -a not_created_users

function create_user {

    # $1=user | $2=home_dir | $3=shell | $4=groups | $5=full_name | $6=comment | $7=password
  
    #Si no se introduce shell se pone una default

    if [[ -z $3 ]];then
  
      shell="/bin/false"
  
    fi

    #Si no especifica el home se pone uno default

    if [[ -z $2 ]];then

      sudo useradd -s "$3" -c "$6" -G "$4" "$1"

    else

      sudo useradd -m -d "$2" -s "$3" -c "$6" -G "$4" "$1"

    fi

    # Comprobación si se ha creado el usuario correctamente, en caso de que no, guarda el nombre en un array

    if [ $? -eq 0 ]; then

      if [ -n $7 ]; then
      
        echo "$1:$7" | sudo chpasswd

      fi

      else

        not_created_users+=("$1")
          
    fi
    
}

#revisar

function multiple_users {

  message="\nIntroduzca la ruta donde está el archivo .csv\n\nEl archivo .csv ha de tener el siguiente formato:\n\nuser,full_name,home_dir,shell,comment,password,groups\n\nEn caso de no tener claro algun campo o directamente no quieres asignarle un valor, dejalo en blanco. La contraseña ha de estar en texto plano. Asegurate de que los grupos son existentes y que esten separados por espacios --> rrhh prueba1 android"

  dialog --stdout --title "$title" --msgbox "$message" 0 0
  
  csv_path=$(dialog --stdout --title "$title" --fselect /home/ 0 0)
  
  while IFS=";" read -r user home_dir shell groups full_name comment password; do

    create_user $user $home_dir $shell $groups $full_name $comment $password

  done < $csv_path

}

#No funciona bien

function one_user {

  message="\nEn caso de no tener claro algun campo o directamente no quieres asignarle un valor, dejalo en blanco. La contraseña ha de estar en texto plano. Asegurate de que los grupos son existentes y que esten separados por espacios --> rrhh prueba1 android"

  user_data=($(dialog --title "$title" --form "$message" 18 50 0 \
                "Usuario:"          1 1 "" 1 18 50 0 \
                "Directorio Home:"  2 1 "" 2 18 50 0 \
                "Shell:"            3 1 "/bin/bash" 3 18 50 0 \
                "Grupos:"           4 1 "" 4 18 50 0 \
                "Nombre Completo:"  5 1 "" 1 18 50 0 \
                "Comentario:"       6 1 "" 2 18 50 0 \
                "Contraseña:"       7 1 "" 3 18 50 0 3>&1 1>&2 2>&3))

  #user_data=(${user_data1[0]} ${user_data1[1]} ${user_data1[2]} ${user_data1[3]} ${user_data2[0]} ${user_data2[1]} ${user_data2[2]})

  message="\nEstá seguro que desea crear el usuario con los siguientes datos:\n\nUsuario: ${user_data[0]}\nNombre Completo: ${user_data[4]}\nDirectorio Home: ${user_data[1]}\nShell: ${user_data[2]}\nComentario: ${user_data[5]}\nContraseña: ${user_data[6]}\nGrupos: ${user_data[3]}"

  check=$(dialog --title "$title" --yesno "$message" 0 0)

  if [[ $check -eq 0 ]]; then

    create_user ${user_data[@]}

  else 

    one_user

  fi

}

one_user

if [ ${#not_created_users[@]} -eq 0 ];then

  message="\nSe han creado todos los usuarios del .csv"

  else

  message="\nLos siguientes usuarios no han sido creados, revise el .csv:\n\n"

fi

dialog --title "$title" --msgbox "$message" 0 0 0 
