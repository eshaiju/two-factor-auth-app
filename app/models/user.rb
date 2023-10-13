# frozen_string_literal: true

require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: { message: 'Email has already been taken' }

  validates_presence_of :password, on: :create, message: "Password can't be blank"
  validates_confirmation_of :password

  def secret_key
    if self[:secret_key].blank?
      new_key = ROTP::Base32.random
      update(secret_key: new_key)
    end
    self[:secret_key]
  end
end
