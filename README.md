
# TFG - Script administración servidores ubuntu

Hola buenas, mi nombre es Alberto Belmonte Gómez, y este mega script es mi TFG, dicho script es capaz de administrar un servidor ubuntu, permitiendonos lo siguiente:

- Gestionar las tarjetas de red y del firewall
- Gestionar usuarios y grupos locales
- administrar los discos del sistema
- Gestionar procesos
- Programar tareas
- Realizar configuración básica, como administrar repositorios, cambiar la hora del sistema, cambiar el idioma...
- Apagar y reiniciar el equipo

En mi caso estoy haciendo el proyecto en ubuntu server 22.04, ya que es la distribución más empleada, no estoy seguro de si funcionaría correctamente en servidores debian, gentoo, centOS...

El proyecto todavía NO está terminado.
 
## Herramientas empleadas

He tratado de emplear herramientas que previamente ya están instaladas en la distribución ubuntu o de que normal esten en todas las distribuciones linux 

- **Dialog**: para la interfaz del script
- **Crontab**: para programar tareas
- **ufw**: para administrar las reglas del firewall
- **netplan**: para administrar las tarjetas de red
- **timedatectl**: para configurar la fecha y la hora del equipo

## Instalación

Para usar dicho script necesitamos tener previamente instalado **dialog**, **ufw**, **netplan** y **cron**:

### apt

```yaml
sudo apt install dialog ufw netplan cron
```

## Uso

cuando tengas ya todo instalado, clonas este repositorio, y le das permisos de ejecución al archivo **ubunadm.sh** 

```yaml
chmod +x ubunadm.sh
```

ejecutalo como usuario root o con sudo para su correcto funcionamiento

```yaml
sudo ./ubunadm.sh
```

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
