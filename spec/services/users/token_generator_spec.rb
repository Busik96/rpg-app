# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::TokenGenerator, type: :services do
  subject(:service) { described_class.new.call(user) }

  let(:user) { create :user }

  describe 'generates api token for user' do
    it 'returns api token correctly' do
      service
      expect(user.api_key).not_to eq(nil)
    end
  end
end
