#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
mkdir -p upgrade
docker compose exec db pg_dumpall -U ephios > ./upgrade/sqldump.sql

docker compose pull && docker compose up --no-start && docker compose start db
docker compose cp upgrade/sqldump.sql db:/tmp
docker compose exec db psql -U ephios -f /tmp/sqldump.sql