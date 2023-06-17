#!/bin/bash

docker compose exec -w /etc/caddy -it caddy caddy reload
