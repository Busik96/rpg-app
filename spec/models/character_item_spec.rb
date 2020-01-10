# frozen_string_literal: true

# == Schema Information
#
# Table name: character_items
#
#  id           :bigint           not null, primary key
#  amout        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :bigint           not null
#  item_id      :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_character_items_on_character_id  (character_id)
#  index_character_items_on_item_id       (item_id)
#  index_character_items_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (character_id => characters.id)
#

require 'rails_helper'

RSpec.describe CharacterItem, type: :model do
  let!(:user) { create :user }
  let(:character) { create :character, user: user }
  let(:item) { create :item, character_items: character_item }
  let(:character_item) { create :character_item,
                         items: item, character: character }
  subject { described_class.new }

  describe 'associations' do
    it { is_expected.to belong_to(:character) }
    it { is_expected.to belong_to(:item) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amout) }
    it { is_expected.to validate_numericality_of(:amout) }
  end
end
