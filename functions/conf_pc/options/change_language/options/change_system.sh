#!/bin/bash

# Establecer la codificación
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

message="\nSeleccione a que idioma y codificación desea asignar al sistema (esto no influye en el teclado), actualmente tiene puesto $LANG"

lan_opt=($(locale -a))

for ((i=0; i<${#lan_opt[@]}; i++)); do

  chose+=("${lan_opt[$i]}" " ")

done

# Mostrar el menú

choice=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${chose[@]}")

message="\nActualemente tiene $LANG y va a cambiar al idioma $choice, esto afecta al formato de la hora, moneda, idioma...¿Está seguro?"

dialog --stdout --title "$title" --yesno "$message" 0 0

if [ $? -eq 0 ]; then

  sed -i "s/^LANG=.*/LANG=$choice/" /etc/default/locale
  sed -i "s/^LC_ALL=.*/LC_ALL=$choice/" /etc/default/locale

fi
