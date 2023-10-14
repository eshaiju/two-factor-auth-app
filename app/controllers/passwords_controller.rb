# frozen_string_literal: true

class PasswordsController < ApplicationController
  before '/passwords/*' do
    redirect '/login' unless logged_in?
  end

  get '/passwords/edit' do
    erb :'/passwords/edit'
  end

  put '/passwords/update' do
    @user = User.find_by_id(session[:user_id])
    form = PasswordUpdateForm.new(
      current_user: @user,
      params: {
        current_password: params[:current_password],
        new_password: params[:new_password],
        confirm_password: params[:confirm_password]
      }
    )

    if form.save
      redirect '/profile'
    else
      @error = form.errors.full_messages.join('. ')
      erb :'/passwords/edit'
    end
  end
end
