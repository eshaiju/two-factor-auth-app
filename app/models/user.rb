# frozen_string_literal: true

require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  validates_presence_of :password, on: :create
  validates_confirmation_of :password
end
