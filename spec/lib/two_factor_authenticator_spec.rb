# frozen_string_literal: true

require 'spec_helper'
require 'two_factor_authenticator'

RSpec.describe TwoFactorAuthenticator do
  describe '.qrcode_data_uri' do
    it 'returns a valid data URI for a given secret key' do
      secret_key = 'base32secret3232'
      issuer = '2FA-AUTH-DEMO-APP'

      data_uri = TwoFactorAuthenticator.qrcode_data_uri(secret_key, issuer: issuer)

      expect(data_uri).not_to be_nil
      expect(data_uri).to include('data:image/png;base64')
    end

    it 'returns nil when the secret key is blank' do
      secret_key = ''

      data_uri = TwoFactorAuthenticator.qrcode_data_uri(secret_key)

      expect(data_uri).to be_nil
    end
  end
end
