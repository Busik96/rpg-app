# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Destroy, type: :request do
  subject(:request) { delete url, headers: headers }

  let(:url) { "/api/v1/characters/#{character.id}" }
  let!(:character) { create :character, user: user }
  let(:user) { create :user }

  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end

  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }

    it 'remove character' do
      expect { request }.to change(Character, :count).by(-1)
    end

    it 'returns status ok' do
      request
      expect(response.body).to include('ok')
    end

    it 'returns 200' do
      request
      expect(response.code).to eq('200')
    end
  end
end
