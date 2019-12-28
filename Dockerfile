FROM elixir:1.9.1-alpine

WORKDIR /app

COPY assets assets
COPY config config
COPY lib lib
COPY priv priv

COPY mix.* ./

RUN apk add --no-cache bash git openssh nodejs npm

RUN cd assets && npm install

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

ENTRYPOINT mix do ecto.migrate, phx.server
