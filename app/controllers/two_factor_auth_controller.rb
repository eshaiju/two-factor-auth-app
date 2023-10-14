# frozen_string_literal: true

class TwoFactorAuthController < ApplicationController
  get '/2fa' do
    erb :'/sessions/2fa'
  end

  post '/2fa' do
    if current_user&.two_factor_enabled?
      @form = TwoFactorForm.new(current_user: current_user, params: params)

      if @form.valid?
        session[:two_factor_authenticated] = true
        redirect '/profile'
      else
        @error = 'Invalid 2FA code'
        erb :'/sessions/2fa'
      end
    else
      erb :'/sessions/login'
    end
  end
end
