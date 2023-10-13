# frozen_string_literal: true

class UsersController < ApplicationController
  get '/users/new' do
    @user = User.new

    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email], password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      ::UserMailer.send_confirmation_email(@user)
      redirect '/'
    else
      erb :'users/new'
    end
  end
end
