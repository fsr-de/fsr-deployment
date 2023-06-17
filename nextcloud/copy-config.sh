#!/bin/bash

if [[ $UID != "0" ]]; then
	echo "This script must be run as root"
	exit 1
fi

docker compose cp ./config/general.config.php nextcloud:/var/www/html/config/general.config.php
docker compose cp ./config/oidc.config.php nextcloud:/var/www/html/config/oidc.config.php

docker compose exec -it nextcloud bash -c 'cd /var/www/html/config && chown www-data:www-data general.config.php && chown www-data:www-data oidc.config.php'
