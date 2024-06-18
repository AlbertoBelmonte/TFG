#!/bin/bash

# Textos del menú

title="Administración del servidor $(hostname)"
message="\nEl menu seleccionado todavía está en desarrollo"

dialog --stdout --title "$title" --msgbox "$message" 0 0
