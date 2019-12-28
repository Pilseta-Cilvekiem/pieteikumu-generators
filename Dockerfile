FROM elixir:1.9.1-alpine

ENV MIX_ENV prod

WORKDIR /app

COPY assets assets
COPY mix.exs .

RUN apk add --no-cache bash git openssh nodejs npm

RUN cd assets && npm install

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --only prod
RUN mix deps.compile
RUN mix compile

ENTRYPOINT mix do ecto.migrate, phx.server
