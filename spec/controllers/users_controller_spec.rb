# frozen_string_literal: true

require 'spec_helper'
require 'rack/test'

RSpec.describe UsersController do
  include Rack::Test::Methods

  describe 'GET /users/new' do
    it 'renders the registration form' do
      get '/users/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Sign Up')
    end
  end

  describe 'POST /users' do
    context 'with valid user data' do
      it 'creates a new user and redirects to the root page' do
        post '/users', { email: 'test@example.com', password: 'password' }

        expect(last_response).to be_redirect
        follow_redirect!

        expect(last_request.path).to eq('/')
      end
    end

    context 'with invalid user data' do
      it 're-renders the registration form' do
        post '/users', { email: '', password: '' }

        expect(last_response).to be_ok
        expect(last_response.body).to include('Sign Up')
      end
    end
  end
end
