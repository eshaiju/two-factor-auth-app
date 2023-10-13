# frozen_string_literal: true

class PasswordsController < ApplicationController
  get '/passwords/edit' do
    erb :'/passwords/edit'
  end

  put '/passwords/update' do
    @user = User.find_by_id(session[:user_id])

    if @user&.authenticate(params[:current_password])
      new_password = params[:new_password]
      confirm_password = params[:confirm_password]

      if new_password == confirm_password
        @user.update(password: new_password)
        redirect '/'
      else
        @error = 'New password and confirmation do not match.'
        erb :'/passwords/edit'
      end
    else
      @error = 'Current password is incorrect.'
      erb :'/passwords/edit'
    end
  end
end
