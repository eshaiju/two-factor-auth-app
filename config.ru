# frozen_string_literal: true

require './config/environment'
require 'pry'

run ApplicationController
use DashboardController
use ProfileController
use UsersController
use SessionsController
use PasswordsController
use TwoFactorAuthController
use TwoFactorSettingsController
