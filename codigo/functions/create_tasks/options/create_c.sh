#!/bin/bash

export LANG="es_ES.UTF-8"

title="\nAdministración del servidor $(hostname)"

function users {

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

}

function enter_command {

  message="\nEscriba la ruta absoluta del comando o script a ejecutar:\n Ejemplo: /usr/backups/copias.sh"

  selected_command=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

}

function comment {

  message="\n¿Desea añadir una nota a la tarea?, si no lo desea deje en blanco el campo de texto"

  selected_comment=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

}

function time_selected {

  message="\nSeleccione en que momento del día desea que se ejecute la tarea (también se tienen en cuenta los segundos, para asignar un valor ha de usar las flechas del teclado)"

  array_time=()

  while true; do

    selected_time=$(dialog --stdout --title "$title" --timebox "$message" 0 0)

    # Comprobar si el usuario a presionado a cancelar

    if [[ -z $array_time && $? -eq 1 ]]; then

      message="\nNo ha seleccionado ningún hora, si no lo añade se ejecutará cada minuto. ¿Estás seguro?"

      input_alert "$array_time" "time_selected" "$message"

      if [ $? -eq 0 ]; then
      
        break
      
      else 
      
        continue
      
      fi

      else 

        dialog --stdout --title "$title" --yesno "\n¿Desea añadir otro momento de ejecución?" 0 0    

    fi

    if [ $? -eq 1 ]; then

      array_time+=("$selected_time")

      break
      
    fi

    array_time+=("$selected_time")

  done
  
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

  selected_day=()

  selected_day=$(dialog --stdout --title "$title" --checklist "\nSeleccionar día(s) de la semana" 0 0 0 "${day_a[@]}")

  # Comprobar si el usuario a presionado a cancelar

  message="\nNo ha seleccionado ningún día, si no lo añade se ejecutará todos los días. ¿Estás seguro?"

  input_alert "$selected_day" "days" "$message"

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

    selected_months=()

    selected_months=$(dialog --stdout --title "$title" --checklist "\nSeleccionar mes(es) del año" 0 0 0 "${month_a[@]}")

  # Comprobar si el usuario a presionado a cancelar

    message="\nNo ha seleccionado ningún mes, si no lo añade se ejecutará todos los meses. ¿Estás seguro?"

    input_alert "$selected_months" "months" "$message"
}

function input_alert {

    array=$1
    nom_func=$2
    message=$3

    if [ -z $array ]; then

        dialog --stdout --title "$title" --yesno "$message" 0 0

        if [ $? -eq 1 ]; then

            "$nom_func"
        
        fi
    
    fi


}

users && enter_command && comment && time_selected && days && months
