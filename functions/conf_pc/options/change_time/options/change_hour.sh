#!/bin/bash

# Establecer la codificación para caracteres especiales como las tildes y la ñ
export LANG="es_ES.UTF-8"

title="Administración del servidor $(hostname)"

message="\nVa ha cambiar la hora a mano, ¿Está seguro de ello?"

dialog --stdout --title "$title" --yesno "$message" 0 0


