# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # TODO: Tighten this down in production.
    resource '*', headers: :any, methods: %i[get post patch put options]
  end
end
