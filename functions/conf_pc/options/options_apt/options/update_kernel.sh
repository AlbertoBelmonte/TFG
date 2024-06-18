#!/bin/bash

# Textos del menú

title="Administración del servidor $(hostname)"
message="\n¿Quiere actualizar el kernel? Actualmente tiene el kernel $(uname -r)"

# Mostrar el diálogo de confirmación
#
dialog --stdout --title "$title" --yesno "$message" 0 0

# Verificar la opción seleccionada por el usuario

if [ $? -eq 0 ]; then

  # Actualizar los repositorios
  
  if sudo apt update -y; then
  
  # Instalar la última versión del kernel genérico
  
    if sudo apt install linux-generic -y; then
    
      # Mostrar mensaje de éxito y preguntar por reinicio
      
      dialog --stdout --title "$title" --msgbox "\nKernel actualizado correctamente.\n\nSe recomienda reiniciar el sistema." 0 0
      
      dialog --stdout --title "$title" --yesno "\n¿Quiere reiniciar ahora?" 0 0

      # Verificar si el usuario desea reiniciar
      
      if [ $? -eq 0 ]; then
        
        sudo reboot
        
      fi
        
      else
      
      # Mostrar mensaje de error al instalar el kernel
      
      exit_code=$?
      
      dialog --stdout --title "$title" --msgbox "\nError al instalar el kernel.\n\nCódigo de salida: $exit_code" 0 0
      
    fi
    
  else
  
  # Mostrar mensaje de error al actualizar los repositorios
  
  exit_code=$?
  
  dialog --stdout --title "$title" --msgbox "\nError al actualizar los repositorios.\n\nCódigo de salida: $exit_code" 0 0
  
  fi

fi
