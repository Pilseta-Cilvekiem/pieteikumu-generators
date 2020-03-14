FROM elixir:1.9-alpine

WORKDIR /app

COPY config config
COPY lib lib
COPY priv priv
COPY mix.* ./
COPY .env .env
RUN export $(egrep -v '^#' .env | xargs)
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

RUN apk add --no-cache npm
COPY assets assets
RUN cd assets && npm install

ENTRYPOINT mix phx.server