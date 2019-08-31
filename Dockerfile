FROM ruby:2.6.3

# Run updates
RUN apt-get update -qq && apt-get install -y build-essential mysql-client node.js

# Set locale to input multibyte character
# See:
# https://blog.unresolved.xyz/docker-multibyte/
# Install language pack for Debian
RUN apt-get update -qq && apt-get install -y task-japanese
ENV LANG C.UTF-8

# Set root dir for app
ENV HOME /root
ENV APP_ROOT /usr/local/app

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# from file path in host to file path in Docker image
COPY Gemfile* $APP_ROOT/

# Install gems
RUN bundle install && bundle clean

# Upload source
COPY . $APP_ROOT
