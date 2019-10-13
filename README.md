# Pieteikumu būvētājs

## Set up

- install docker
- `cp .env.example .env`
- `docker-compose up -d`. `d` flag to start as deamon in background.
- will start in `80` port

## Basic auth

- in `.env` file fill both `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD` env variables to enable basic auth.