#!/bin/sh

cd /app

# install git
apk update
apk upgrade
apk add --no-cache bash git openssh nodejs npm

mix local.hex --force
mix local.rebar --force

mix deps.get

# mix ecto.create
# mix ecto.migrate

# mix test

mix phx.server