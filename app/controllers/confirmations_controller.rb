# frozen_string_literal: true

# ConfirmationsController
class ConfirmationsController < Devise::ConfirmationsController
  def show
    token = params[:confirmation_token]
    user = User.find_or_initialize_with_error_by(:confirmation_token, token)

    results = Authentication::ConfirmUser.call(user: user)

    if results.success?
      render template: 'users/confirm_user_success', status: :ok
    else
      render template: 'shared/silent_reply', status: :bad_request
    end
  end
end
