# frozen_string_literal: true

require 'spec_helper'

describe User do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(email: 'user@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid if password and password confirmation do not match' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'different_password')
      expect(user).not_to be_valid
    end
  end

  context 'password encryption' do
    it 'verifies the password correctly' do
      password = 'password'
      user = User.create(email: 'user@example.com', password: password)

      authenticated_user = User.find_by(email: 'user@example.com').authenticate(password)

      expect(authenticated_user).to eq(user)
    end

    it 'does not authenticate with an incorrect password' do
      password = 'password'
      User.create(email: 'user@example.com', password: password)

      authenticated_user = User.find_by(email: 'user@example.com').authenticate('wrong_password')

      expect(authenticated_user).to be false
    end
  end

  describe '#secret_key' do
    context 'when the user has no secret key' do
      it 'generates and saves a new secret key' do
        user = User.create(email: 'test@example.com', password: 'password')

        expect(user.secret_key).not_to be_blank
      end
    end

    context 'when the user already has a secret key' do
      it 'returns the existing secret key' do
        existing_key = ROTP::Base32.random
        user = User.create(email: 'test@example.com', password: 'password', secret_key: existing_key)

        expect(user.secret_key).to eq(existing_key)
      end
    end
  end
end
