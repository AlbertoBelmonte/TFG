
# TFG - Script administración servidores ubuntu

Hola buenas, mi nombre es Alberto Belmonte Gómez, y este mega script es mi TFG, dicho script es capaz de administrar un servidor UNIX/LINUX, permitiendonos lo siguiente:

- Gestionar las tarjetas de red y del firewall
- Gestionar usuarios y grupos locales
- administrar los discos del sistema
- Gestionar procesos
- Programar tareas
- Realizar configuración básica, como administrar repositorios, cambiar la hora del sistema, cambiar el idioma...
- Apagar y reiniciar el equipo

He tratado de emplear herramientas que previamente ya están instaladas en el sistema o de que normal que esten en todas las distribuciones linux 

El proyecto todavía NO está terminado

## Herramientas empleadas

- **Dialog**: para la interfaz del script
- **Crontab**: para programar tareas
- **ufw**: para administrar las reglas del firewall
- **netplan**: para administrar las tarjetas de red

## Instalación

Para usar dicho script necesitamos tener previamente instalado dialog:

### apt

```yaml
sudo apt install dialog
```

### pacman 

```yaml
sudo pacman -S dialog
```

## Uso

cuando tengamos ya instalado dialog, clonas este repositorio y ejecutas el fichero codigo/ubunadm.sh, ejecutalo como usuario root o con sudo si no, no te dejerá usarlo

## Estado proyecto

- [5%] Gestionar las tarjetas de red y del firewall
- [5%] Gestionar usuarios y grupos locales
- [5%] administrar los discos del sistema
- [5%] Gestionar procesos
- [70%] Programar tareas
- [5%] Realizar configuración básica, como administrar repositorios, cambiar la hora del sistema, cambiar el idioma...
- [100%] Apagar y reiniciar el equipo

## Autor

- [@AlbertoBelmonte](https://github.com/AlbertoBelmonte)
