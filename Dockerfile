FROM elixir:1.9.1-alpine

WORKDIR /app

COPY assets assets
COPY config config
COPY lib lib
COPY priv priv

COPY mix.* ./

# RUN apk add --no-cache bash git openssh nodejs npm

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

RUN cd assets && npm install

ENTRYPOINT mix phx.server
