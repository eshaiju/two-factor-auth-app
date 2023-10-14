# frozen_string_literal: true

require 'spec_helper'

describe 'Profile', type: :feature do
  before do
    user = FactoryBot.create(:user, email: 'user@example.com', password: 'password')

    login_user(user.email, user.password)
  end

  it 'displays the profile page when logged in' do
    visit '/profile'

    expect(page).to have_link('Edit Password', href: '/passwords/edit')
    expect(page).to have_link('Enable Two-Factor Authentication', href: '/2fa/setup')
  end
end
