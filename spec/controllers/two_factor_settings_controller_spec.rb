# frozen_string_literal: true

require 'spec_helper'

describe TwoFactorSettingsController do
  include Rack::Test::Methods

  let(:user) { FactoryBot.create(:user, two_factor_enabled: false) }

  before do
    login_user
  end

  describe 'GET /2fa/setup' do
    it 'renders the 2FA setup page' do
      get '/2fa/setup'

      expect(last_response).to be_ok
      expect(last_response.body).to include('Enable Two-Factor Authentication')
    end
  end

  describe 'POST /2fa/verify' do
    context 'with a valid code' do
      it 'enables two-factor authentication and redirects' do
        post '/2fa/verify', code: valid_2fa_code(user)

        user.reload
        expect(user.two_factor_enabled).to be(true)
        expect(last_response).to be_redirect
        follow_redirect!

        expect(last_request.path).to eq('/profile')
      end
    end

    context 'with an invalid code' do
      it 'shows an error message and does not enable two-factor authentication' do
        post '/2fa/verify', code: 'invalid_code'

        user.reload
        expect(user.two_factor_enabled).to be(false)

        expect(last_response).to be_ok
        expect(last_response.body).to include('Invalid 2FA code')
      end
    end
  end

  describe 'POST /2fa/disable' do
    it 'disables two-factor authentication and redirects' do
      post '/2fa/disable', disable_2fa: true

      user.reload
      expect(user.two_factor_enabled).to be(false)
      expect(last_response).to be_redirect
      follow_redirect!

      expect(last_request.path).to eq('/profile')
    end
  end

  def login_user
    post '/login', email: user.email, password: 'password'
  end
end
