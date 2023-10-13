# frozen_string_literal: true

require 'spec_helper'

feature 'User Sessions' do
  scenario 'User logs in with valid credentials' do
    User.create(email: 'test@example.com', password: 'password')

    visit '/login'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Welcome, test@example.com')
  end

  scenario 'User enters incorrect credentials' do
    visit '/login'
    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Sign In'

    expect(page).to have_content('Incorrect email or password')
  end
end
