# frozen_string_literal: true

class PasswordUpdateForm
  include ActiveModel::Model

  attr_accessor :current_password, :new_password, :confirm_password, :current_user

  validates :current_password, :new_password, :confirm_password, presence: true
  validate :password_match
  validate :current_password_correct

  def initialize(current_user:, params: {})
    @current_user = current_user
    super(params)
  end

  def save
    return false unless valid?

    current_user.update(password: new_password)
    true
  end

  private

  def password_match
    return if new_password == confirm_password

    errors.add(:new_password, 'and confirmation do not match.')
  end

  def current_password_correct
    return if current_user&.authenticate(current_password)

    errors.add(:current_password, 'is incorrect.')
  end
end
