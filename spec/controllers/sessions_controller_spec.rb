# frozen_string_literal: true

require 'spec_helper'
require 'rack/test'

describe SessionsController do
  include Rack::Test::Methods

  def app
    SessionsController
  end

  describe 'GET /login' do
    it 'renders the login page' do
      get '/login'

      expect(last_response).to be_ok
      expect(last_response.body).to include('Log In')
    end
  end

  describe 'POST /login' do
    context 'with valid credentials' do
      let(:user) { User.create(email: 'test@example.com', password: 'password') }

      it 'redirects to the root page' do
        post '/login', email: user.email, password: 'password'
        expect(last_response).to be_redirect
        follow_redirect!
        expect(last_request.path).to eq('/')
      end
    end

    context 'with invalid credentials' do
      it 'renders the login page with an error message' do
        post '/login', email: 'invalid@example.com', password: 'wrongpassword'
        expect(last_response).to be_ok
        expect(last_response.body).to include('Log In')
        expect(last_response.body).to include('Incorrect email or password')
      end
    end
  end
end
