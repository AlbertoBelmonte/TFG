
# TFG - Script administración servidores ubuntu

Hola buenas, mi nombre es Alberto Belmonte Gómez, y este mega script es mi TFG, dicho script es capaz de administrar un servidor ubuntu, permitiendonos lo siguiente:

- Gestionar las tarjetas de red y del firewall
- Gestionar usuarios y grupos locales
- administrar los discos del sistema
- Gestionar procesos
- Programar tareas
- Realizar configuración básica, como administrar repositorios, cambiar la hora del sistema, cambiar el idioma...
- Apagar y reiniciar el equipo

El proyecto todavía NO está terminado

## Herramientas empleadas

- **Dialog**: para la interfaz del script
- **Crontab**: para programar tareas

## Instalación

Para usar dicho script necesitamos tener previamente instalado dialog:

### apt

sudo apt install dialog

### pacman 

sudo pacman -S dialog

cuando tengamos ya instalado dialog, clonas este repositorio y ejecutas el fichero codigo/ubunadm.sh, ejecutalo como usuario root o con sudo si no, no te dejerá usarlo

## Autor

- [@AlbertoBelmonte](https://github.com/AlbertoBelmonte)
