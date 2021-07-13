# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include Authorization::Helpers

  # I'm going to leave this here for now, but if it causes issues, get rid of it and let each controller
  # determine their own authentication needs.
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Authorization::NotAuthorizedError, with: :account_not_authorized

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

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end

  private

  def account_not_authorized
    render jsonapi_errors: 'Access denied.', status: 403
  end
end
