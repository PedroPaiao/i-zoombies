require 'rails_helper'

RSpec.describe Survivor, type: :model do
  context 'Validate survivor name attribute' do
    it 'Survivor is valid' do
      survivor = Survivor.new(name: 'Pedro Augusto', gender: :male)
      expect(survivor).to be_valid
    end

    it 'Name is invalid, because is required' do
      survivor = Survivor.new(gender: :female)
      expect(survivor).to be_invalid
    end
  end

  context 'Validate survivor gender attribute' do
    it 'Survivor is valid' do
      survivor = Survivor.new(name: 'Pedro Augusto', gender: :male)
      expect(survivor).to be_valid
    end

    it 'Gender is invalid, because is required' do
      survivor = Survivor.new(name: 'Pedro Augusto')
      survivor.valid?
      expect(survivor.errors[:gender]).to include("can't be blank")
    end
  end
end
