#!/bin/bash

title="Administración del servidor $(hostname)"

check_ntp=$(timedatectl show | grep -w 'NTP=yes')

if [ -z $check_ntp ]; then

  message="\nTiene DESACTIVADA la sincronización con su servidor NTP, ¿Desea activarla?"

else
      
  message="\nTiene ACTIVADO la sincronización con su servidor NTP, ¿Desea desactivarla?"

fi

dialog --stdout --title "$title" --yesno "$message" 0 0

#if [ $? -eq 0 ]; then

   

#fi
