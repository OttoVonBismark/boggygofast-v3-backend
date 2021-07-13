# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include Authorization::Helpers
  rescue_from Authorization::NotAuthorizedError, with: :account_not_authorized

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
