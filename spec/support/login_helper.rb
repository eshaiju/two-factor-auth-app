# frozen_string_literal: true

module LoginHelper
  def login_user(email, password)
    visit '/login'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign In'
  end
end
