#! /bin/bash

docker run \
  -it \
  -p 5432:5432 \
  --rm \
  --network crazy-train \
  -e POSTGRES_PASSWORD=password \
  --name crazy-train-postgres \
  postgres
