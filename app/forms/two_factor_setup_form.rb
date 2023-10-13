# frozen_string_literal: true

class TwoFactorSetupForm
  include ActiveModel::Model

  attr_accessor :code, :current_user

  validates :code, presence: true

  def initialize(current_user:, params: {})
    @current_user = current_user
    super(params)
  end

  def qrcode_data_uri
    ::TwoFactorAuthenticator.qrcode_data_uri(current_user.secret_key)
  end

  def valid_code?
    totp = ROTP::TOTP.new(current_user.secret_key)
    verification_result = totp.verify(code)

    !verification_result.nil?
  end

  def enable_two_factor
    return unless valid_code?

    current_user.update(two_factor_enabled: true)
    true
  end
end
