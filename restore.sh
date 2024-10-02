#!/bin/bash

# Переменные
DB_CONTAINER_NAME="db"
DB_VOLUME_NAME="module5_week3"
BACKUP_FILE="./backups/backup-2024-09-29T16-41-00.tar.gz"

# Остановка контейнера базы данных
docker-compose stop $DB_CONTAINER_NAME

# Восстановление данных из бэкапа
docker run --rm \
  --volume $DB_VOLUME_NAME:/db_data \
  --volume $(pwd):/backup \
  ubuntu \
  tar xzvf /backup/$BACKUP_FILE -C /db_data

# Запуск контейнера базы данных
docker-compose start $DB_CONTAINER_NAME

echo "Восстановление данных завершено."