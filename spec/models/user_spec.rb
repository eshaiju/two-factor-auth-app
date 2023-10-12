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
end
