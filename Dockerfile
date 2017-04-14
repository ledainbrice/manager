FROM alpine:edge

ENV PORT 4000
ENV APP_HOME /app

RUN apk add --no-cache --update \
      bash git \
      make gcc g++ libc-dev inotify-tools \
      elixir \
      erlang-dev erlang-crypto erlang-syntax-tools erlang-dev erlang-sasl erlang-tools erlang-parsetools \
      python \
      nodejs nodejs-npm


RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR $APP_HOME

EXPOSE $PORT

CMD ["mix", "phoenix.server"]
