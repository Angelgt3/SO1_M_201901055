read -p "Ingrese el nombre de usuario de GitHub: " GITHUB_USER

API_URL="https://api.github.com/users/$GITHUB_USER"
USER_DATA=$(curl -s "$API_URL")

USER_ID=$(echo "$USER_DATA" | jq -r '.id')
CREATED_AT=$(echo "$USER_DATA" | jq -r '.created_at')

LOG_DIR="/tmp/$(date +'%Y%m%d')"
LOG_FILE="$LOG_DIR/saludos.log"

mkdir -p "$LOG_DIR"

echo "Hola $GITHUB_USER. User ID: $USER_ID. Cuenta fue creada el: $CREATED_AT." >> "$LOG_FILE"

echo "Registro creado en: $LOG_FILE"

CRON_JOB="*/5 * * * * $(pwd)/script.sh"
(crontab -l ; echo "$CRON_JOB") | crontab -
