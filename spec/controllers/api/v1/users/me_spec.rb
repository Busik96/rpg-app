# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Me, type: :request do
  subject(:request) { get url, headers: headers }

  let(:url) { "/api/v1/users/me" }
  let!(:character) { create :character, user: user }
  let!(:user) { create :user }
  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end


  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }
    let(:correct_attributes) do
      {
        'id' => user.id,
        'email' => user.email
      }
    end

    it 'returns character details correctly' do
      request
      expect(json_response_body['data']['attributes']).to eq(correct_attributes)
    end

    it 'returns relationships details correctly' do
      request
      expect(json_response_body['data']['relationships']).to include('characters')
    end

    it 'returns code 200' do
      request
      expect(response.code).to eq('200')
    end
  end
end
