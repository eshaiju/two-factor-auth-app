# frozen_string_literal: true

class TwoFactorAuthController < ApplicationController
  get '/2fa/setup' do
    if logged_in?
      @qrcode_data_uri = ::TwoFactorAuthenticator.qrcode_data_uri(current_user.secret_key)

      erb :'2fa/setup'
    else
      redirect '/login'
    end
  end

  post '/2fa/verify' do
    totp = ROTP::TOTP.new(current_user.secret_key)

    if totp.verify(params[:code])
      current_user.update(two_factor_enabled: true)
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
