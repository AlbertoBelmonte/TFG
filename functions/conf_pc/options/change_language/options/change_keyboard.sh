#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

key_ins=($(cat /etc/locale.gen | tail -n +7 | sed 's/^# //' | awk '{print $1, $2}'))

actual_key=$(grep -v '^#' /etc/locale.gen | tail -n +3)

chose=()

for ((i=0; i<${#key_ins[@]}; i++)); do

    chose+=("${key_ins[$i]}" "")

done

message="\n¿Qué distribución de teclado desea tener? Actualmente tiene: $actual_key"

selected_key=$(dialog --stdout --title "$title" --menu "$message" 0 0 0 "${chose[@]}")

# No me devuelve correctamente el nombre completo me devuelve:
# C.UTF-8
# UTF-8
#
# Cuando ha de ser C.UTF-8 UTF-8

echo ${key_ins[0]}
echo ${key_ins[1]}

#message="\n¿Está seguro que desea cambiar de su actual teclado $actual_key, a $selected_key?"
#
#dialog --stdout --title "$title" --yesno "$message" 0 0
#
#if [ $? -eq 0 ]; then
#
#  sed -i "s/^ $actual_key/# $selected_key/" /etc/locale.gen
#  sed -i "s/^# $selected_key/ $selected_key/" /etc/locale.gen
#
#fi
