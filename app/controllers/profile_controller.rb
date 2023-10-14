# frozen_string_literal: true

class ProfileController < ApplicationController
  get '/profile' do
    erb :'/profile/show'
  end

  before '/profile' do
    redirect '/login' unless logged_in?
  end
end
