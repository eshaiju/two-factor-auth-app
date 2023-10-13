# frozen_string_literal: true

# spec/features/password_change_spec.rb

require 'spec_helper'
require 'capybara/rspec'

feature 'Password Change' do
  before do
    @user = User.create(email: 'user@example.com', password: 'password')
    login_user(@user.email, @user.password)
  end

  scenario 'User can change their password' do
    visit '/passwords/edit'

    fill_in 'current_password', with: 'password'
    fill_in 'new_password', with: 'new_password'
    fill_in 'confirm_password', with: 'new_password'
    click_button 'Change Password'

    expect(page).to have_current_path('/')
  end

  scenario 'User cannot change password with incorrect current password' do
    visit '/passwords/edit'

    fill_in 'current_password', with: 'wrong_password'
    fill_in 'new_password', with: 'new_password'
    fill_in 'confirm_password', with: 'new_password'
    click_button 'Change Password'

    expect(page).to have_content('Current password is incorrect.')
  end

  scenario 'User cannot change password with mismatched confirmation' do
    visit '/passwords/edit'

    fill_in 'current_password', with: 'password'
    fill_in 'new_password', with: 'new_password'
    fill_in 'confirm_password', with: 'confirmation_mismatch'
    click_button 'Change Password'

    expect(page).to have_content('New password and confirmation do not match.')
  end
end
