# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory::AddItem, type: :services do
  subject(:service) { described_class.new.call(character, item, amount) }

  let(:character) { create :character, user: user, inventory_size: inventory_size }
  let(:item) { create :item }
  let(:user) { create :user }

  context 'when inventory full' do
    let(:amount) { 6 }
    let(:inventory_size) { 0 }

    it 'returns error messages' do
        expect(service.error).to eq('Inventory is full!')
        expect(service.amount_left).to eq(6)
      end
  end

  context 'when inventory have space' do
    let(:inventory_size) { 20 }

    context 'when stack with item exist' do
      let!(:character_item) { create :character_item, character: character, item: item, amount: 5}
      let(:amount) { 2 }

      it 'adds items to existing stack' do
        expect{ service }.to change{ character_item.reload.amount }.by(amount)
      end
    end

    context 'when amount > existing stack space' do
      let!(:character_item) { create :character_item, character: character, item: item, amount: 5}
      let(:amount) { 10 }

      it 'fills the stack to full' do
        service
        expect(character_item.reload.amount).to eq(CharacterItem::MAX_ITEM_STACK)
      end

      it 'creates new stack with left amount_left' do
        expect{ service }.to change(CharacterItem, :count).by(1)
        expect(CharacterItem.last.amount).to eq(5)
      end
    end
  end
end
