# frozen_string_literal: true

require 'spec_helper'

describe PasswordsController do
  include Rack::Test::Methods

  let(:user) { FactoryBot.create(:user) }

  describe 'GET /passwords/edit' do
    context 'when logged in' do
      before do
        login_user

        get '/passwords/edit'
      end

      it 'renders the password edit page' do
        expect(last_response).to be_ok
        expect(last_response.body).to include('Edit Password')
      end
    end

    context 'when not logged in' do
      it 'redirects to login' do
        get '/passwords/edit'
        follow_redirect!
        expect(last_response).to be_ok
        expect(last_request.path).to eq('/login')
      end
    end
  end

  describe 'PUT /passwords/update' do
    context 'with valid credentials' do
      before do
        login_user
      end

      it 'updates the user password and redirects to the root page' do
        put '/passwords/update',
            { current_password: 'password', new_password: 'new_password', confirm_password: 'new_password' }

        expect(last_response).to be_redirect
        follow_redirect!

        expect(last_request.path).to eq('/profile')
        user.reload
        expect(user.authenticate('new_password')).to be_truthy
      end
    end

    context 'with invalid credentials' do
      before do
        login_user
      end

      it 'renders the password edit page with an error message for incorrect current password' do
        put '/passwords/update',
            { current_password: 'wrong_password', new_password: 'new_password', confirm_password: 'new_password' }
        expect(last_response).to be_ok
        expect(last_response.body).to include('Edit Password')
        expect(last_response.body).to include('Current password is incorrect.')
      end

      it 'renders the password edit page with an error message for confirmation mismatch' do
        put '/passwords/update',
            { current_password: 'password', new_password: 'new_password', confirm_password: 'confirmation_mismatch' }
        expect(last_response).to be_ok
        expect(last_response.body).to include('Edit Password')
        expect(last_response.body).to include('New password and confirmation do not match.')
      end
    end
  end

  def login_user
    post '/login', email: user.email, password: 'password'
  end
end
