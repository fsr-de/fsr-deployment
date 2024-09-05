#!/bin/sh

sudo docker compose exec -it prometheus sh -c '/bin/kill -HUP `pidof prometheus`'
