#! /bin/bash

docker exec \
  -it \
  crazy-train-app \
  ./bin/run-migrations.sh
