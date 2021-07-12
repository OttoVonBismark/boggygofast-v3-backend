# frozen_string_literal: true

# **Permissions Model**
#
# Allows for functional hierarchy of users in a modular format.
# Currently supports :member and :admin, but is easily expandable.
class Permission < ApplicationRecord
  belongs_to :user

  validates :allowed, inclusion: { in: ->(_) { Permission.supported_permissions.map(&:to_s) } }

  class << self
    # a list of valid permissions.
    def supported_permissions
      %i[member admin]
    end
  end
end
