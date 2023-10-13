# frozen_string_literal: true

class TwoFactorSettingsController < ApplicationController
  before '/2fa/*' do
    redirect '/login' unless logged_in?
  end

  get '/2fa/setup' do
    @form = TwoFactorSetupForm.new(current_user: current_user)

    erb :'2fa/setup'
  end

  post '/2fa/verify' do
    @form = TwoFactorSetupForm.new(current_user: current_user, params: params)

    if @form.valid? && @form.enable_two_factor
      session[:two_factor_authenticated] = true
      redirect '/'
    else
      @error = 'Invalid 2FA code'
      erb :'/2fa/setup'
    end
  end

  post '/2fa/disable' do
    current_user.update!(secret_key: nil, two_factor_enabled: false) if params[:disable_2fa]
    redirect '/'
  end

  private

  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end
end
