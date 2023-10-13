# frozen_string_literal: true

require 'sinatra/base' # Your file should require sinatra/base instead of sinatra; otherwise, all of Sinatra’s DSL methods are imported into the main namespace
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/reloader'

class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin
  register Sinatra::ActiveRecordExtension

  configure :development do
    register Sinatra::Reloader

    also_reload 'app/models/**/*.rb'
    also_reload 'lib/**/*.rb'
  end

  configure do
    enable :cross_origin

    set :allow_origin, '*' # allows any origin(domain) to send fetch requests to your API
    # set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :allow_methods, [:get, :options] # allows these HTTP verbs
    set :allow_credentials, true
    set :max_age, 1_728_000
    set :expose_headers, ['Content-Type']

    set :server, :puma

    root_dir = "#{File.dirname(__FILE__)}/../../"
    set :root, root_dir
    set :database_file, File.join(root, 'config/database.yml')

    set :public_folder, File.join(root, '/public')
    set :views, File.join(root, 'app/views')
    set :sessions, true
    set :session_secret, ENV['SESSION_SECRET']
    set :method_override, true
  end

  options '*' do
    response.headers['Allow'] = 'HEAD,GET,POST,DELETE,OPTIONS'
    response.headers['Access-Control-Allow-Headers'] =
      'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
    200
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in?
    return false unless current_user

    return true unless current_user.two_factor_enabled

    two_factor_authenticated?
  end

  def two_factor_authenticated?
    session[:two_factor_authenticated] == true
  end
end
