# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory::UseItem, type: :services do
  subject(:service) { described_class.new.call(character, character_item) }

  let(:character) { create :character, user: user }
  let!(:character_item) { create :character_item, character: character, item: item, amount: amount }
  let(:user) { create :user }

  describe 'when item reusable' do
    let(:item) { create :item, :reusable }
    let(:amount) { 1 }

    it "doesn't change item amount" do
      service
      expect(character_item.amount).to eq(character_item.amount)
    end
  end

  describe 'when item not reusable' do
    let(:item) { create :item }

    context 'if current character amount > 1' do
      let(:amount) { 4 }

      it 'removes 1 piece from the stack' do
        expect { service }.to change(character_item.reload, :amount).by(-1)
      end
    end

    context 'if current character amount = 1' do
      let(:amount) { 1 }

      it 'removes character item' do
        expect{ service }.to change(CharacterItem, :count).by(-1)
      end
    end

  end
end
