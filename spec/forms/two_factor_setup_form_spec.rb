# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TwoFactorSetupForm do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }

  subject { described_class.new(current_user: user, params: params) }

  describe '#enable_two_factor' do
    context 'with valid params' do
      let(:params) { { code: valid_2fa_code(user) } }

      it 'enables two-factor authentication' do
        subject.enable_two_factor

        user.reload

        expect(user.two_factor_enabled).to eq(true)
      end
    end

    context 'with invalid params' do
      let(:params) { { code: 'invalid_code' } }

      it 'does not enable two-factor authentication' do
        subject.enable_two_factor

        user.reload

        expect(user.two_factor_enabled).to eq(false)
      end
    end
  end

  describe '#qrcode_data_uri' do
    let(:params) { { code: valid_2fa_code(user) } }

    it 'returns a valid data URI for a given secret key' do
      data_uri = subject.qrcode_data_uri

      expect(data_uri).not_to be_nil
      expect(data_uri).to include('data:image/png;base64')
    end
  end

  describe '#valid_code?' do
    it 'returns true for a valid code' do
      form = described_class.new(current_user: user, params: { code: valid_2fa_code(user) })

      expect(form.valid_code?).to be true
    end

    it 'returns false for an invalid code' do
      form = described_class.new(current_user: user, params: { code: 'invalid_code' })

      expect(form.valid_code?).to be false
    end
  end
end
