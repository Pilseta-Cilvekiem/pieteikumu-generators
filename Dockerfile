# FROM elixir:1.9.1
# ENV APP_HOME /app

# RUN mix local.hex --force \
#   && mix archive.install --force hex phx_new 1.4.9 \
#   && apt update \
#   && apt install -y certbot \
#   && curl -sL https://deb.nodesource.com/setup_10.x | bash \
#   && apt install -y apt-utils \
#   && apt install -y nodejs \
#   && apt install -y build-essential \
#   && apt install -y inotify-tools \
#   && mix local.rebar --force \
#   && 

# RUN mkdir -p $APP_HOME
# WORKDIR $APP_HOME

# EXPOSE 4000
