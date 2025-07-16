#!/bin/bash

echo "📦 Starte Backup von Minecraft-Welt..."

# Zeitstempel und Pfade
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
WORLD_DIR="/data/worlds/Welt"
BACKUP_DIR="/data/backups"
ZIP_FILE="$BACKUP_DIR/world_backup_$timestamp.zip"

# Dropbox-Konfiguration
DROPBOX_ACCESS_TOKEN="sl.u.AF3ng48UdxJkMJycoAFqgHj1BUkZR7yTTbVcy-PJTBJYr4Gnlt-xb4-vDzeQqbtXOzgjfjHPHHwMhjpQ2iy_AP8uCa6u8IExpJavpGTlr9_l8C3TJEGWd-4BvUSn7WWSmMzMELDnQuO0gnEopLCRncefnV2LrHcbPQh5ZmeduML39b3QcBIP-SxOkonzEtW2EIOryZE4NQDYgNp3Z3I4kWgLSSxjv35T3WPcuQSYFs8cbMHKcTOkRwTQRt9zO7dG_PvTe_jbERjvZMl7K_4_nTkVXb8mRk8_IZlqeBH32ddDe68uDaZcYrkEaFnZE-hLs_be5CmgUgVr3IOBTjS-Gy_ULwqydJJLJTbJuLUbMkoqSY5Z6lUEueilUzdZ00BsinSgmpTAQiYxmG525GZXOztBBMHQeG800ZfhrrziCflw3bTUiw_tmVj_9WX-GSTHStpYy-tAGoW-0kX3UtuTWo_P6ubdgSeSOzTLGB3UfZG7aE5GRTK4k2CQFWX7S-zreUbWKE7Okp_74q1VMJsI79_Si6qfgIyqqrrB7DFmSV4EP0uy5g5xZBzcyTjcmi7cyOZMOvIckXZPvIy8-3aA_LOYdC7mcZDk4vBYRCy3UAMkW5HyM7jkHq1C75Nw4oROQliNwHzRyw7GwckXaEZ5_QpvCyUzz6WBXhyIoKDisOgy-0_uwUEpMXWF_sWbxX3LXM1MeHzdMX5dDIXbR44cubJ0DuOeKYTA1-M05cd0Fb3OfKRJO4QyWrwo0mOuLmcXMAEg3x5b_f8PithRENaN1E2fPzPzmgxPsUSdZwWvS3iakV-P82yJZitg4mawP7-SZv7yQobeEJqXsiH6r3aFFkaW07cqJMvV-8Y5kSFM3RZfPYmJRNAB_4WppZ1NdvFbj-JwvrocZXp9vHk9zoKH_o2SLN0X1MsIBl7vgA5ZnVGPPlJhMXQhtv3-tITQd76QPKnxBHEc3tvf1OoH7hPgl1i8aDexXZ8omJxSQ1wTunEvDFId26vsgdL2hj15-ghrdJCbvwemsCSnNXLF5DqsSeSFXZ4ex5YeoLUXO6nvecSkw_odhbxOD9ehv-QZiapq8jC23DGYLY84qsCDEmjhWCeNfyrSWgbghPZ2ZyinBg-n63T5XSUAnHXzcWViYXDzSybxd89kDHr4fyE_-h2avMxQ2MrkQdenv7lmotDAGbKI8F9WE1NlGKnX4HpK_UILod8eIdmZzWAPt7sLV-uMcgKvrhLkoaCBNhHxGmWbhuC8aQLeXr9hta4UlfLjLTO43GkplxiBLwbcSE8keAdNTbd9"
DROPBOX_TARGET="/minecraft-backups/world_backup_$timestamp.zip"

# Backup-Ordner erstellen
mkdir -p "$BACKUP_DIR"

# Welt zippen
zip -r "$ZIP_FILE" "$WORLD_DIR"

echo "✅ ZIP erstellt: $ZIP_FILE"

# Datei zu Dropbox hochladen
echo "☁️  Lade Backup zu Dropbox hoch..."

curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer $DROPBOX_ACCESS_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"$DROPBOX_TARGET\", \"mode\": \"add\", \"autorename\": true, \"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @"$ZIP_FILE"

echo "✅ Hochladen abgeschlossen."

# Starte Minecraft-Server
cd /data
exec ./bedrock_server