# frozen_string_literal: true

require 'spec_helper'

describe PasswordUpdateForm do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }

  describe 'validations' do
    context 'with valid parameters' do
      it 'is valid' do
        form = PasswordUpdateForm.new(current_user: user,
                                      params: {
                                        current_password: 'password',
                                        new_password: 'new_password',
                                        confirm_password: 'new_password'
                                      })
        expect(form).to be_valid
      end
    end

    context 'with invalid parameters' do
      it 'is invalid when the current password is incorrect' do
        form = PasswordUpdateForm.new(current_user: user,
                                      params: {
                                        current_password: 'wrong_password',
                                        new_password: 'new_password',
                                        confirm_password: 'new_password'
                                      })
        expect(form).to be_invalid
        expect(form.errors[:current_password]).to include('is incorrect.')
      end

      it 'is invalid when the new password and confirmation do not match' do
        form = PasswordUpdateForm.new(current_user: user,
                                      params: {
                                        current_password: 'password',
                                        new_password: 'new_password',
                                        confirm_password: 'confirmation_mismatch'
                                      })
        expect(form).to be_invalid

        expect(form.errors[:new_password]).to include('and confirmation do not match.')
      end
    end
  end

  describe '#save' do
    it 'updates the user password and returns true when given valid parameters' do
      form = PasswordUpdateForm.new(current_user: user,
                                    params: {
                                      current_password: 'password',
                                      new_password: 'new_password',
                                      confirm_password: 'new_password'
                                    })
      expect(form.save).to be(true)
      user.reload
      expect(user.authenticate('new_password')).to be_truthy
    end

    it 'does not update the user password and returns false when given invalid parameters' do
      form = PasswordUpdateForm.new(current_user: user,
                                    params: {
                                      current_password: 'wrong_password',
                                      new_password: 'new_password',
                                      confirm_password: 'confirmation_mismatch'
                                    })
      expect(form.save).to be(false)
      user.reload
      expect(user.authenticate('new_password')).to be_falsey
    end
  end
end
