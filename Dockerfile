FROM elixir:1.9.2-alpine

# Install hex & rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

RUN apk add --update nodejs npm bash inotify-tools

#EXPOSE 4000

# Intall phoenix
ENV PHOENIX_VERSION=1.4.10
#RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new-${PHOENIX_VERSION}.ez
RUN mix archive.install hex phx_new ${PHOENIX_VERSION} --force

WORKDIR /app
ADD . /app

RUN mix deps.get

RUN cd assets && npm install

CMD mix phx.server
