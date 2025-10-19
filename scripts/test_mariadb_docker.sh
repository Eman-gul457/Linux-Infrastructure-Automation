#!/bin/bash
# test_mariadb_docker.sh - test connection to MariaDB container (clean output)

LOG=~/linux-infra-automation/scripts/mariadb_docker_test.log
exec > >(tee -a "$LOG") 2>&1

CONTAINER_NAME="project-mariadb"
PROJECT_USER="projectuser"
PROJECT_PASS="projectpass123"

echo "=== Test: Show databases via container client ==="
sudo docker exec -i $CONTAINER_NAME mariadb -u"$PROJECT_USER" -p"$PROJECT_PASS" -e "SHOW DATABASES;"

echo "=== Test: Verify access to projectdb ==="
sudo docker exec -i $CONTAINER_NAME mariadb -u"$PROJECT_USER" -p"$PROJECT_PASS" -e "USE projectdb; CREATE TABLE IF NOT EXISTS demo(id INT PRIMARY KEY, name VARCHAR(20)); SHOW TABLES;"

echo "=== Test: Confirm user identity (safe check) ==="
sudo docker exec -i $CONTAINER_NAME mariadb -u"$PROJECT_USER" -p"$PROJECT_PASS" -e "SELECT CURRENT_USER();"

echo "=== Done ==="
echo "Log: $LOG"
