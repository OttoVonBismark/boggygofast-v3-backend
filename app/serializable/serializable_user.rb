# frozen_string_literal: true

# User Serializer
class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes %i[email username]

  link :self do
    @url_helpers.api_user_url(@object.id)
  end
end
