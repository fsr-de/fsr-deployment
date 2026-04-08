#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
mkdir -p upgrade
docker compose exec db pg_dumpall -U myhpi > ./upgrade/sqldump.sql

docker compose down
docker volume rm myhpi_myhpi_postgres_data

docker compose pull && docker compose up --no-start && docker compose start db
docker compose cp upgrade/sqldump.sql db:/tmp

sleep 5 # Wait 5 seconds for the container to start
docker compose exec db psql -U myhpi -f /tmp/sqldump.sql