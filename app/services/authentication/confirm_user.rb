# frozen_string_literal: true

# Authentication Service
module Authentication
  # Confirm user with matching confirmation token
  class ConfirmUser < Service
    include Authorization::BypassPermissions

    # Confirms the given User.
    # @param user [User] The user to be confirmed
    # @return [Response] Contains success/fail information.
    def call(user:)
      if user.needs_confirmation?
        User.transaction(requires_new: true) do
          confirm_user(user)
        end
      elsif user.confirmed_at.present?
        user.errors.add(:email, user_already_confirmed)
        response.status = :errors
      end

      response.success = true if response.status == :success

      response
    end

    private

    def confirm_user(user)
      user.confirm
      response.status = :success
    end
  end
end
