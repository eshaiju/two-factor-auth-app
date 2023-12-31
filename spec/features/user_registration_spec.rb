# frozen_string_literal: true

require 'spec_helper'

describe 'User Registration' do
  context 'when registration succeeds' do
    before do
      visit '/users/new'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'secure_password'
      click_button 'Register'
    end

    it 'redirects the user to the homepage' do
      expect(page).to have_current_path('/')
    end

    it 'sends a confirmation email to the user' do
      email = Mail::TestMailer.deliveries.last

      expect(email.to).to include('newuser@example.com')
      expect(email.subject).to eq('Confirmation Email')
    end
  end

  context 'when registration fails' do
    it 'displays an error message when email has already been taken' do
      FactoryBot.create(:user, email: 'eshaiju@gmail.com', password: 'secure_password')

      visit '/users/new'
      fill_in 'Email', with: 'eshaiju@gmail.com'
      fill_in 'Password', with: 'password123'
      click_button 'Register'

      expect(page).to have_content('Email has already been taken')
    end

    it 'displays an error message when password is blank' do
      visit '/users/new'
      fill_in 'Email', with: 'newuser@example.com'
      click_button 'Register'

      expect(page).to have_content("can't be blank")
    end
  end
end
