#!/bin/sh

set -e 

# check the presence of a file .env

if [ ! -f /api/.env ] 
then
    docker stop phoenix
else
    ./.env
fi

mix ecto.create
mix ecto.migrate

mix phx.server








