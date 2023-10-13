# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UserMailer do
  describe '.send_confirmation_email' do
    it 'sends a confirmation email with the expected content' do
      user = User.create(email: 'user@example.com', password: 'password')

      UserMailer.send_confirmation_email(user).deliver

      email = Mail::TestMailer.deliveries.last
      html_body = email.html_part.body.to_s

      expect(email.to).to include(user.email)
      expect(email.from).to include('noreply@example.com')
      expect(email.subject).to eq('Confirmation Email')
      expect(html_body).to include('Thank you for registering!')
      expect(html_body).to include('Your account has been successfully registered.')
    end
  end
end
