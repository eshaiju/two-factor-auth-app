# frozen_string_literal: true

module TwoFactorAuthenticator
  class << self
    def qrcode_data_uri(secret_key, issuer: '2FA-AUTH-DEMO-APP')
      return nil if secret_key.blank?

      totp = ROTP::TOTP.new(secret_key)

      qrcode = RQRCode::QRCode.new(totp.provisioning_uri(issuer))
      @qrcode_data_uri = qrcode.as_png(size: 200).to_data_url
    end
  end
end
