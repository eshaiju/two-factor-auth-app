# frozen_string_literal: true

require 'spec_helper'

feature 'User Sessions' do
  before do
    @user = FactoryBot.create(:user)
  end

  scenario 'User logs in with valid credentials' do
    visit '/login'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Welcome, test@example.com')

    click_button 'Log Out'

    expect(page).to have_content('Log In')
  end

  scenario 'User enters incorrect credentials' do
    visit '/login'
    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Sign In'

    expect(page).to have_content('Incorrect email or password')
  end

  it 'allows a user to log in with 2FA' do
    @user.update!(two_factor_enabled: true)

    visit '/login'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_current_path('/2fa')

    fill_in 'two_factor_code', with: valid_2fa_code(@user)
    click_button 'Submit'

    expect(page).to have_current_path('/profile')
  end
end
