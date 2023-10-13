# frozen_string_literal: true

class Add2faToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :secret_key, :string
    add_column :users, :two_factor_enabled, :boolean, default: false
    add_column :users, :backup_codes, :text, array: true, default: []
  end
end
