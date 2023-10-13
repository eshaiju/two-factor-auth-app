# frozen_string_literal: true

source 'http://rubygems.org'
ruby '3.1.2'

gem 'activerecord', '~> 6.0', '>= 6.0.3.2', require: 'active_record'
gem 'bcrypt'
gem 'pg'
gem 'pony'
gem 'pry'
gem 'puma'
gem 'rack-contrib'
gem 'racksh'
gem 'rake'
gem 'require_all'
gem 'rotp'
gem 'rqrcode'
gem 'shotgun'
gem 'sinatra'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'sinatra-contrib', require: false
gem 'sinatra-cross_origin'
gem 'sinatra-jsonp'
gem 'tux'

group :development, :test do
  gem 'dotenv'
  gem 'session_secret_generator'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test'
  gem 'rspec'
end
