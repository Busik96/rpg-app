# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inventory::DivideItem, type: :services do
  subject(:service) { described_class.new.call(character, character_item, desired_amount) }

  let(:character) { create :character, user: user }
  let!(:character_item) { create :character_item, character: character, item: item, amount: amount }
  let(:item) { create :item }
  let(:user) { create :user }

  describe 'with valid amount' do
    let(:desired_amount) { 2 }
    let(:amount) { 6 }

    it "changes character item amount" do
      expect{ service }.to change(character_item, :amount).by(-desired_amount)
    end

    it "creates new stack" do
      expect{ service }.to change(CharacterItem, :count).by(1)
      expect(CharacterItem.last.amount).to eq(desired_amount)
    end
  end

  describe 'with invalid amount' do

    context 'if character item amount = 1' do
      let(:desired_amount) { 1 }
      let(:amount) { 1 }

      it 'returns error message' do
        expect(service.error).to eq("You have only 1 item. You can't divided it")
      end
    end

    context 'if desired_amount > current character amount' do
      let(:desired_amount) { 3 }
      let(:amount) { 2 }

      it 'returns error message' do
        expect(service.error).to eq('Please enter a smaller number')
      end
    end

    context 'if desired_amount = current character amount' do
      let(:desired_amount) { 2 }
      let(:amount) { 2 }

      it 'returns error message' do
        expect(service.error).to eq('Please enter a smaller number')
      end
    end

  end
end
