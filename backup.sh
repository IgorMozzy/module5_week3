#!/bin/bash

COMPOSE_PROJECT_NAME="module5_week3"
DB_CONTAINER_NAME="db"
DB_VOLUME_NAME="${COMPOSE_PROJECT_NAME}_db_data"
BACKUP_DIR="/path/to/backup/directory"
BACKUP_FILE="db_backup_$(date +%Y%m%d_%H%M%S).tar.gz"

docker-compose stop $DB_CONTAINER_NAME

if [ $? -ne 0 ]; then
    echo "Ошибка при остановке контейнера базы данных!"
    exit 1
fi

docker run --rm \
  --volume $DB_VOLUME_NAME:/db_data \
  --volume $BACKUP_DIR:/backup \
  ubuntu \
  tar czf /backup/$BACKUP_FILE -C /db_data .

if [ $? -ne 0 ]; then
    echo "Ошибка при создании бэкапа!"
    docker-compose start $DB_CONTAINER_NAME  # Восстанавливаем контейнер, если что-то пошло не так
    exit 1
fi

docker-compose start $DB_CONTAINER_NAME

if [ $? -ne 0 ]; then
    echo "Ошибка при запуске контейнера базы данных!"
    exit 1
fi

echo "Бэкап успешно выполнен: $BACKUP_DIR/$BACKUP_FILE"
