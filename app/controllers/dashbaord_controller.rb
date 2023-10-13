# frozen_string_literal: true

class DashboardController < ApplicationController
  get '/' do
    erb :'/dashboard/index'
  end

  before '/' do
    redirect '/login' unless logged_in?
  end
end
