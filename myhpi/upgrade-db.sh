#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
mkdir -p upgrade
docker compose exec myhpi_postgres pg_dumpall -U myhpi > ./upgrade/sqldump.sql

sleep 5

docker compose down
docker volume rm myhpi_myhpi_postgres_data

docker compose pull && docker compose up --no-start && docker compose start myhpi_postgres
docker compose cp upgrade/sqldump.sql myhpi_postgres:/tmp

sleep 5 # Wait 5 seconds for the container to start
docker compose exec myhpi_postgres psql -U myhpi -f /tmp/sqldump.sql