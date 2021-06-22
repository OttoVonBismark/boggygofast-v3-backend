FROM ruby:3.0.1-alpine3.13

WORKDIR /app

RUN apk --update add \
  bash \
  build-base \
  git \
  postgresql-dev \
  python2 \
  python3 \
  tzdata \
  yaml-dev \
  zlib-dev

COPY Gemfile* ./

RUN MKFLAGS=-j$(nproc) \
  bundle install

COPY . /app

EXPOSE 3000

CMD ["bundle", "exec", "rails", "console"]
