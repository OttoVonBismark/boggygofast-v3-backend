# frozen_string_literal: true

# API Base Controller. Essentially ApplicationController, but exclusively for API stuff.
class Api::BaseController < ApplicationController
  # I'm going to leave this here for now, but if it causes issues, get rid of it and let each controller
  # determine their own authentication needs.
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: {
      errors: [
        {
          status: '404',
          title: 'Not Found'
        }
      ]
    }, status: 404
  end
end