# frozen_string_literal: true

require 'spec_helper'
require 'capybara/rspec'

describe 'Enabling Two-Factor Authentication' do
  it 'enables 2FA for the user' do
    user = FactoryBot.create(:user, email: 'user@example.com', password: 'password')

    login_user(user.email, user.password)

    click_link 'Enable Two-Factor Authentication'

    fill_in 'code', with: valid_2fa_code(user)
    click_button 'Enable 2FA'

    user.reload
    expect(page).to have_content('Two-Factor Authentication is Enabled')

    expect(user.two_factor_enabled).to be(true)
  end
end
