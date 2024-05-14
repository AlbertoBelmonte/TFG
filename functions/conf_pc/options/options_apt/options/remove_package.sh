#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

r_package=""

# Esta funcion pregunta al usuario si quiere elimanar los archivos de configuración de los paquetes seleccionados y los elimina

function purge_remove {

  message="\n¿Desea tambíen eliminar los archivos de configuración de los paquetes $r_package?"

  r_conf=$(dialog --stdout --title "$title" --yesno "$message" 0 0)

  if [ $r_conf -eq 0 ] ;then

    sudo apt purge $r_package -y
  
    message="\nLos paquetes $r_package con su configuración han sido eliminados"

    dialog --stdout --title "$title" --msgbox "$message" 0 0

  else 
 
    sudo apt remove $r_package -y
  
    message="\nLos paquetes $r_package han sido eliminados"

    dialog --stdout --title "$title" --msgbox "$message" 0 0

  fi

}

function list_package {

  # Obtener y preparar los paquetes que tiene instalado el SO, para mostrarlos en un menu

  temp_list_pack=$(mktemp)

  ins_packages=$(apt list --installed | tail -n +2 > $temp_list_pack)

  nam_package=($(awk '{print $1}' $temp_list_pack | cut -d'/' -f1))

  rep_package=($(awk '{print $1}' $temp_list_pack | cut -d'/' -f2- | sed 's/,now//'))

  ver_package=($(awk '{print $2}' $temp_list_pack))

# Creación array con los datos

  chose=()

  for ((i=0; i<${#nam_package[@]}; i++)); do

    rep_ver="${rep_package[$i]} - ${ver_package[$i]}"

    chose+=("${nam_package[$i]}" "$rep_ver" "\"off\"")

  done

}

# Textos del menú

title="Administración del servidor $(hostname)"

message="\n¿Sabe que paquete en concreto desea desinstalar?, en caso de no saberlo le mostraré una lista donde seleccionará que paquetes quiere desinstalar"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  message="\nIndique que programa desea eliminar. Si es más de uno, separelos con espacios en blanco.\n\nEjemplo: ssh firefox bind9"

  r_package=$(dialog --stdout --title "$title" --inputbox "$message" 0 0)

  if [ $? -eq 0 ]; then
  
    purge_remove

  else 

    echo "saliendo"

  fi

else 

  list_package

  message="\nListado de los paquetes instalados en el sistema, seleccione cual o cuales quiere eliminar"

  r_package=$(dialog --stdout --title "$title" --checklist "$message" 0 0 0 "${chose[@]}")

  if [ $? -eq 0 ]; then
  
    purge_remove

  else 

    echo "saliendo"

  fi

fi
