# frozen_string_literal: true

module LoginHelper
  def login_user(email, password)
    visit '/login'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign In'
  end

  def login_user_with_2fa(user)
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    fill_in 'two_factor_code', with: valid_2fa_code(user)
    click_button 'Submit'
  end

  def valid_2fa_code(user)
    totp = ROTP::TOTP.new(user.secret_key)
    totp.now
  end
end
