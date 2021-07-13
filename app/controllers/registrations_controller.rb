# frozen_string_literal: true

# Registrations Controller
class RegistrationsController < Devise::RegistrationsController
  def create
    response = Users::CreateUser.call(user_info: user_params)

    if response.success?
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
