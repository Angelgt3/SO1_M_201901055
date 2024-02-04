___
**Actividad 2**
___
***Descripcion***
Crear un script en BASH que permita consultar los datos de un usuario de GITHUB. Los datos del usuario seran descargado de un webservice. Luego este debera de escribir un log con algunos de los datos del usario.

Tareas a realizar por el script:

    Lea la variable GITHUB_USER
    Consulte la URL https://api.github.com/users/ concatenando el valor de la variable GITHUB_USER al final
    Imprimir el mensaje: “Hola <github_user>. User ID: <id>. Cuenta fue creada el: <created_at>.” Los valores entre los signos <> deben de ser tomados del JSON colsutado previamente.
    Crear un log file en /tmp/<fecha>/saludos.log con la salida del mensaje anterior. Donde <fecha> corresponde a la fecha del día de ejecución del script
    Crear un cronjob para que el script se ejecute cada 5 minutos
___
***Script en Bash***

Solicita al usuario que ingrese el nombre de usuario de GitHub se almacena en la variable GITHUB_USER
```bash
read -p "Ingrese el nombre de usuario de GitHub: " GITHUB_USER
```
Consulta a la URL concatenada con la variable GITHUB_USER para obtener los datos del usuario y guardala en la variable USER_DATA
```bash
API_URL="https://api.github.com/users/$GITHUB_USER"
USER_DATA=$(curl -s "$API_URL")
```
Guarda los valores necesarios del json
```bash
USER_ID=$(echo "$USER_DATA" | jq -r '.id')
CREATED_AT=$(echo "$USER_DATA" | jq -r '.created_at')
```
Crea un log file en /tmp/<fecha>/saludos.log
```bash
LOG_DIR="/tmp/$(date +'%Y%m%d')"
LOG_FILE="$LOG_DIR/saludos.log"
```
Crea el directorio si este no existe
```bash
mkdir -p "$LOG_DIR"
```
Escribe el mensaje en el log file
```bash
echo "Hola $GITHUB_USER. User ID: $USER_ID. Cuenta fue creada el: $CREATED_AT." >> "$LOG_FILE"
```
Imprime en pantalla que se creo el log file
```bash
echo "Registro creado en: $LOG_FILE"
```
Crear un cronjob para que el script se ejecute cada 5 minutos
```bash
CRON_JOB="*/5 * * * * $(pwd)/script.sh"
(crontab -l ; echo "$CRON_JOB") | crontab -
```
___
***Ejecucion***

Se ejecuta en el directorio donde se encutra el script
```cmd
./github_script.sh
```