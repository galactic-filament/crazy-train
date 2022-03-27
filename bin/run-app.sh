#! /bin/bash

DATABASE_HOST=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' crazy-train-postgres)

docker run \
  -it \
  -p 8080:80 \
  --rm \
  --network crazy-train \
  -e DATABASE_HOST="$DATABASE_HOST" \
  -e DATABASE_URI="postgresql://postgres:password@$DATABASE_HOST:5432/postgres" \
  -e APP_LOG_DIR=/tmp \
  -e APP_PORT=80 \
  -e JWT_SECRET='JWT_SECRET' \
  --name crazy-train-app \
  galactic-filament/crazy-train
