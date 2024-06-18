#!/bin/bash

title="Administración del servidor $(hostname)"

# Función para obtener la información de una interfaz dada

get_interface_info() {

    iface="$1"
    ipv4=$(ip a show $iface | grep -E 'inet ' | awk '{print $2}')
    ipv6=$(ip a show $iface | grep -E 'inet6 ' | awk '{print $2}')
    mac=$(ip a show $iface | grep -E 'link/ether ' | awk '{print $2}')
    gateway=$(ip route show default 0.0.0.0/0 | grep "dev $iface" | awk '{print $3}')

    echo "\nIPv4: $ipv4\nIPv6: $ipv6\nMAC: $mac\nPuerta de enlace: $gateway"

}

# Obtener la lista de interfaces de red excluyendo lo

interfaces=$(ip a | grep -E '^[0-9]+: ' | awk '{print $2}' | sed 's/://' | grep -v '^lo$')

# Array para almacenar las opciones de dialog

options=()

for iface in $interfaces; do

    info=$(get_interface_info $iface)
    options+=("$iface" "$info")

done

# Mostrar el menú usando dialog

message="\nListado de NIC instaladas en el sistema, para ver más detalles seleccione una NIC"

choice=$(dialog --title "$title" --cancel-label "Atras" --menu "$message" 0 0 0 "${options[@]}" 2>&1 >/dev/tty)

# Mostrar la información de la interfaz seleccionada

if [ -n "$choice" ]; then

  info=$(get_interface_info $choice)
  
  dialog --title "Información de $choice" --msgbox "$info" 0 0

fi
