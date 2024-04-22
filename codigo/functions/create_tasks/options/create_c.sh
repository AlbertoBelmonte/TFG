#!/bin/bash

export LANG="es_ES.UTF-8"

function users {

  message="Seleccione el usuario"
  path_r_users="/tmp/temp_users"
  
  awk -F: '{print $3 ":" $1}' /etc/passwd | sort -n | awk -F: '{print $2 " " $1}' > $path_r_users
    
  users=($(awk '{print $1}' $path_r_users))
  ids=($(awk '{print $2}' $path_r_users))
  
  chose=()

  for ((i=0; i<${#users[@]}; i++)); do

    chose+=("${users[$i]}" "${ids[$i]}")

  done

  selected_user=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${chose[@]}")

}

function time_selected {

  message="\nSeleccione en que momento del día desea que se ejecute la tarea (también se tienen en cuenta los segundos, para asignar un valor ha de usar las flechas del teclado)"

  array_time=()

  while true; do

    selected_time=$(dialog --stdout --title "$title" --timebox "$message" 0 0)

    again_time=$(dialog --stdout --title "$title" --yesno "\n¿Desea añadir otro momento de ejecución?" 0 0)

    if [ $? -eq 1 ]; then

      array_time+=("$selected_time")

      break

    fi
        
      array_time+=("$selected_time")

  done
  
}

function months {

    month_a=(
      1  "Enero"      "off"
      2  "Febrero"    "off"
      3  "Marzo"      "off"
      4  "Abril"      "off"
      5  "Mayo"       "off"
      6  "Junio"      "off"
      7  "Julio"      "off"
      8  "Agosto"     "off"
      9  "Septiembre" "off"
      10 "Octubre"    "off"
      11 "Noviembre"  "off"
      12 "Diciembre"  "off"
      13 "*"          "off"
    )

    selected_months=$(dialog --stdout --title "$title" --checklist "Seleccionar mes(es) del año" 0 0 13 "${month_a[@]}")

}


function days {

  day_a=(
      1  "Lunes"      "off"
      2  "Martes"     "off"
      3  "Miercoles"  "off"
      4  "Jueves"     "off"
      5  "Viernes"    "off"
      6  "Sábado"     "off"
      7  "Domingo"    "off"
      8  "*"          "off"
  )

  selected_day=$(dialog --stdout --title "$title" --checklist "Seleccionar día(s) de la semana" 0 0 8 "${day_a[@]}")

}

function enter_command {

  message="Escriba la ruta absoluta del comando o script a ejecutar:\n Ejemplo: /usr/backups/copias.sh"

  selected_command=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

}

function change_editor {


}

title="Administración del servidor $(hostname)"
message=""

choice=$(dialog --title "$title" --msgbox "$message" 0 0)
