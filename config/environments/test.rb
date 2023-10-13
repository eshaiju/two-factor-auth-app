# frozen_string_literal: true

require 'pony'

Pony.options = {
  from: 'noreply@example.com',
  via: :test
}
