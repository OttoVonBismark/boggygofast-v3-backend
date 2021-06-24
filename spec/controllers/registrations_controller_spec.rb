# frozen_string_literal: true

require 'rails_helper'

describe RegistrationsController, type: :request do # Note the type. For testing APIs, use the request type.
  let(:new_user) { build(:user) }
  let(:existing_user) { create(:user) }
  let(:signup_url) { '/api/signup' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: new_user.email,
          password: new_user.password,
          username: 'New User'
        }
      }
    end

    it 'returns 201 (created)' do
      expect(response.status).to eq(201)
    end

    it 'contains a message hinting at confirmation' do
      expect(json['message']).to eq(
        'Account created successfully. Please check your email for confirmation instructions.'
      )
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password,
          username: 'Existing User'
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(400)
    end
  end
end
