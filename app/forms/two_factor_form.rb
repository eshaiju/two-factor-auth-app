# frozen_string_literal: true

class TwoFactorForm
  include ActiveModel::Model

  attr_accessor :two_factor_code, :current_user

  validate :validate_two_factor_code

  def initialize(current_user:, params: {})
    @current_user = current_user
    super(params)
  end

  def validate_two_factor_code
    return unless two_factor_code

    totp = ROTP::TOTP.new(current_user.secret_key)

    return if totp.verify(two_factor_code)

    errors.add(:two_factor_code, 'is invalid')
  end
end
