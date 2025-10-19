#!/bin/bash
# setup_mariadb_docker.sh - Run MariaDB in Docker for project (with logging)

LOGFILE=~/linux-infra-automation/scripts/mariadb_docker_setup.log
exec > >(tee -a "$LOGFILE") 2>&1

CONTAINER_NAME="project-mariadb"
VOLUME_NAME="projectdb-data"
ROOT_PASS="rootpass123"
PROJECT_DB="projectdb"
PROJECT_USER="projectuser"
PROJECT_PASS="projectpass123"
IMAGE="mariadb:latest"

echo "=== Prereqs: create docker volume ==="
sudo docker volume create $VOLUME_NAME >/dev/null || true

echo "=== Pulling MariaDB image ==="
sudo docker pull $IMAGE

echo "=== Stopping & removing any existing container named $CONTAINER_NAME ==="
sudo docker rm -f $CONTAINER_NAME >/dev/null 2>&1 || true

echo "=== Running MariaDB container ==="
sudo docker run -d \
  --name $CONTAINER_NAME \
  -e MARIADB_ROOT_PASSWORD="$ROOT_PASS" \
  -e MARIADB_DATABASE="$PROJECT_DB" \
  -e MARIADB_USER="$PROJECT_USER" \
  -e MARIADB_PASSWORD="$PROJECT_PASS" \
  -v $VOLUME_NAME:/var/lib/mysql \
  -p 3306:3306 \
  $IMAGE

echo "=== Waiting for container to be ready (checking logs) ==="
# Wait until MariaDB reports "ready for connections" or timeout
TRIES=0
while ! sudo docker logs $CONTAINER_NAME 2>&1 | grep -q "ready for connections"; do
  sleep 1
  TRIES=$((TRIES+1))
  if [ $TRIES -gt 30 ]; then
    echo "ERROR: container did not become ready in time. See logs with: sudo docker logs $CONTAINER_NAME"
    exit 1
  fi
done

echo "=== Container ready. Show running container ==="
sudo docker ps --filter "name=$CONTAINER_NAME" --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

echo "=== Quick verify: show databases using container client ==="
sudo docker exec -i $CONTAINER_NAME mariadb -u"$PROJECT_USER" -p"$PROJECT_PASS" -e "SHOW DATABASES;"

echo "=== MariaDB Docker setup complete ==="
echo "Container: $CONTAINER_NAME, DB: $PROJECT_DB, User: $PROJECT_USER"
echo "Log saved to: $LOGFILE"
                               
