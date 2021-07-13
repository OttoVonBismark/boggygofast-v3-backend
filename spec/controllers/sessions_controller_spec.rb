# frozen_string_literal: true

require 'rails_helper'

describe SessionsController, type: :request do
  let(:user) { create(:user) }
  let(:login_url) { '/api/login' }
  let(:logout_url) { '/api/logout' }

  context 'When logging in' do
    before do
      login_with_api(user)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end

  context 'When logging out' do
    it 'returns 204' do
      delete logout_url

      expect(response).to have_http_status(204)
    end

    it 'expires the JWT, returning 401 on subsequent access attempts' do
      login_with_api(user)

      delete logout_url
      get "/api/users/#{user.id}"
      expect(response).to have_http_status(401)
    end
  end
end