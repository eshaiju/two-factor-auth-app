# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TwoFactorForm do
  let(:user) { FactoryBot.create(:user) }

  context 'with a valid two-factor code' do
    let(:params) { { two_factor_code: valid_2fa_code(user) } }

    it 'is valid' do
      form = TwoFactorForm.new(current_user: user, params: params)
      expect(form).to be_valid
      expect(form.errors[:two_factor_code]).to be_empty
    end
  end

  context 'with an invalid two-factor code' do
    let(:params) { { two_factor_code: 'invalid_code' } }

    it 'is invalid and has an error' do
      form = TwoFactorForm.new(current_user: user, params: params)
      expect(form).not_to be_valid
      expect(form.errors[:two_factor_code]).to include('is invalid')
    end
  end
end
