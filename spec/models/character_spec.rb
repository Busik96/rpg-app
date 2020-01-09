# frozen_string_literal: true

# == Schema Information
#
# Table name: characters
#
#  id             :bigint           not null, primary key
#  description    :text
#  inventory_size :integer          default(20)
#  name           :string
#  stats          :jsonb
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_characters_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Character, type: :model do
  let!(:user) { create :user }
  let(:character) { create :character, user: user }
  subject { described_class.new }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:items).through(:character_items) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:inventory_size) }
    it { is_expected.to validate_length_of(:description) }
  end
end
