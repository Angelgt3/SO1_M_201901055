___
# Actividad 3
___
***Descripcion***
Crear un systemd unit de tipo servicio que realice lo siguiente.
Ejecutar un script imprima un saludo y la fecha actual infinitamente con una pausa de un segundo.
Habilitar el servicio para que se inicie con el sistema 

## PASOS DE CREACION E INSTALACION
___
***Script***
EL script 'script.sh' realizar un bucle infinito que imprime un saludo junto a la fecha y hora actual.

```bash
while true
do
    echo "Hola, La fecha y hora actual es: $(date)"
    sleep 1
done
``` 
___
***Permisos***

Se le da permisos de ejecucion 
```cmd
chmod +x /home/usuario/mi_script.sh
```

***Permisos***
Se crea un 'script.sh' que realiza un bucle infinito que imprime un saludo junto a la fecha y hora actual.

```bash
while true
do
    echo "Hola, La fecha y hora actual es: $(date)"
    sleep 1
done
```

***Sevicio systemd***
Se crea un archivo service 'saludo.service' donde se establece la ejecucion del script como un servicio del sistema.

```service
[Unit]
Description=Mi servicio personalizado

[Service]
ExecStart=/home/usuario/mi_script.sh

[Install]
WantedBy=multi-user.target
```

***Inicializacion del servicio***
Inicia el servicio
```cmd
sudo systemctl start saludo
```
Se habilita para que inicie con el sistema 
```cmd
sudo systemctl enable saludo
```

***Inicializacion del servicio***
Para ver los registros del servicio se utiliza el siguiente comando:
```cmd
journalctl -u saludo
```