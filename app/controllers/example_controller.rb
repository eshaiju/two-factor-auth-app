# frozen_string_literal: true

class ExampleController < ApplicationController
  get '/' do
    content_type :html
    erb :'/about.html'
  end
end
