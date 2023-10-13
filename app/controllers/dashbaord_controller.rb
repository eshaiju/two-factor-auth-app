# frozen_string_literal: true

class DashboardController < ApplicationController
  get '/' do
    if session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
      erb :'/dashboard/index'
    else
      redirect '/login'
    end
  end
end
