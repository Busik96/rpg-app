# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  stats       :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { create :item }
  subject { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:stats) }
    it { is_expected.to validate_length_of(:description) }
  end
end
