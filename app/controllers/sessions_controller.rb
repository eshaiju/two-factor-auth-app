# frozen_string_literal: true

class SessionsController < ApplicationController
  get '/login' do
    erb :'/sessions/login'
  end

  post '/login' do
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      if user.two_factor_enabled?
        redirect '/2fa'
      else
        redirect '/'
      end
    else
      @error = 'Incorrect email or password'
      erb :'/sessions/login'
    end
  end

  delete '/logout' do
    session.clear
    redirect '/'
  end
end
