# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

return if Rails.env.production?

# rubocop:disable Style/MixinUsage
include FactoryBot::Syntax::Methods
# rubocop:enable Style/MixinUsage

full_permissions = Permission.supported_permissions

create(:user,
       email: 'user@example.com',
       username: 'example_user')

create(:user,
       email: 'admin@example.com',
       username: 'admin_user',
       with_permissions: full_permissions)
