# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Items::Show, type: :request do
  subject(:request) { get url }

  let(:url) { "/api/v1/items/#{item.id}" }
  let!(:item) { create :item }
  let(:correct_attributes) do
    {
      'name' => item.name,
      'description' => item.description,
      'stats' => item.stats,
      'reusable' => item.reusable
    }
  end

  it 'returns item details correctly' do
    request
    expect(json_response_body['data']['attributes']).to eq(correct_attributes)
  end

  it 'returns code 200' do
    request
    expect(response.code).to eq('200')
  end
end
