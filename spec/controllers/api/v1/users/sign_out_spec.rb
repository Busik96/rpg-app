# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::SignOut, type: :request do
  subject(:request) { get url, headers: headers }

  let(:url) { "/api/v1/users/sign_out" }
  let!(:user) { create :user }
  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end

  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }

    it 'change api key to nil' do
      request
      expect(User.last.api_key).to eq(nil)
    end

    it 'returns status ok' do
      request
      expect(json_response_body['status']).to eq('ok')
    end

    it 'returns code 200' do
      request
      expect(response.code).to eq('200')
    end
  end
end
