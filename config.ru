# frozen_string_literal: true

require './config/environment'
run ApplicationController
use DashboardController
use UsersController
