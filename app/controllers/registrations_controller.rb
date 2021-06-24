# frozen_string_literal: true

# Registrations Controller
class RegistrationsController < Devise::RegistrationsController
  # Gonna be real. I dunno what the hell this is. Probably gonna refactor it.
  def create
    user = User.create(user_params)
    if user.persisted?
      render template: 'users/create_success', status: :created
    else
      render template: 'shared/silent_reply', status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
