# frozen_string_literal: true

class TwoFactorAuthController < ApplicationController
  get '/2fa' do
    erb :'/sessions/2fa'
  end

  post '/2fa' do
    if current_user&.two_factor_enabled?
      two_factor_code = params[:two_factor_code]
      totp = ROTP::TOTP.new(current_user.secret_key)

      if totp.verify(two_factor_code)
        session[:two_factor_authenticated] = true
        redirect '/'
      else
        @error = 'Invalid 2FA code'
        erb :'/sessions/2fa'
      end
    else
      erb :'/sessions/login'
    end
  end
end
