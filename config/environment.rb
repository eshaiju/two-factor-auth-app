# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

Dotenv.load

require './app/controllers/application_controller'
require './app/mailers/user_mailer'
require_all 'app'
require_all 'lib'

# Load the environment-specific configuration
if ENV['RACK_ENV'] == 'test'
  require_relative 'environments/test'
else
  require_relative 'environments/development'
end
