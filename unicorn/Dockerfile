FROM ruby:2.7.4

RUN apt-get update -qq && apt-get install psmisc

WORKDIR /sample
COPY ["./src/Gemfile", "./"]

RUN gem install bundler --version 1.17.2 && bundle install
COPY . /sample
