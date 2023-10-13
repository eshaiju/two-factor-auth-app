# frozen_string_literal: true

require 'pony'

class UserMailer
  ROOT_DIR = File.expand_path('..', __dir__)

  def self.send_confirmation_email(user)
    template_path = File.join(ROOT_DIR, 'views/user_mailer/confirmation_email.html.erb')

    Pony.mail(
      to: user.email,
      subject: 'Confirmation Email',
      html_body: File.read(template_path)
    )
  end
end
