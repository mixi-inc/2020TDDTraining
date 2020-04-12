FROM ruby:2.6.3

ENV APP_ROOT=/app

RUN set -ex

RUN curl -sL https://deb.nodesource.com/setup_10.x && \
    apt-get update -qq && \
    apt-get install -y nodejs

RUN apt-get update -qq && \
    gem install rails --version="6.0.2"

RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT
