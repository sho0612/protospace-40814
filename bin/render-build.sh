#!/usr/bin/env bash

# Exit on error
set -o errexit

# Install dependencies
bundle install
yarn install

# If using a database, run migrations
bundle exec rake db:migrate