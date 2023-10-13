# frozen_string_literal: true

class DashboardController < ApplicationController
  get '/' do
    erb :'/dashboard/index'
  end
end
