# frozen_string_literal: true

require 'spec_helper'
require 'capybara/rspec'

RSpec.feature 'Disable Two-Factor Authentication' do
  scenario 'User disables 2FA' do
    user = FactoryBot.create(:user, two_factor_enabled: true)

    login_user_with_2fa(user)

    check 'disable_2fa'

    click_button 'Save'

    expect(page).to have_content('Enable Two-Factor Authentication')
    expect(user.reload.two_factor_enabled).to be_falsey
  end
end
