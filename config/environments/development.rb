# frozen_string_literal: true

require 'pony'

Pony.options = {
  from: 'noreply@example.com',
  via: :smtp,
  via_options: {
    address: '127.0.0.1',
    port: '1025'
  }
}
