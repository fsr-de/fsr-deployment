#!/bin/bash

sleep 5
php artisan migrate
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
while true
    do
    sleep 60
    echo "Wallet backend healthy"
    done
exec "$@"
