#!/bin/bash

# Establecer la codificación
title="Administración del servidor $(hostname)"

lang=$(locale | grep -w 'LANG' | cut -c 6-)

message="\nSeleccione en que idioma y codificación, desea asignar al sistema (esto no influye en el teclado), actualmente tiene el sistema en $lang"

lan_opt=($(locale -a))

for ((i=0; i<${#lan_opt[@]}; i++)); do

  chose+=("${lan_opt[$i]}" " ")

done

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${chose[@]}")

message="\nActualmente tiene $lang y va a cambiar al idioma $choice, esto afecta al formato de la hora, moneda, idioma...¿Está seguro?"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  if [ -f /etc/default/locale ]; then

  sed -i "s/^LANG=.*/LANG=$choice/" /etc/default/locale
  sed -i "s/^LC_ALL=.*/LC_ALL=$choice/" /etc/default/locale

  export LANG="$choice"
  export LC_ALL="$choice"

  else

    echo "El archivo /etc/default/locale no existe. No se pueden realizar cambios."
    exit 1

  fi

else

  exit

fi
