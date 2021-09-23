require 'rails_helper'

RSpec.describe Location, type: :model do
  let!(:survivor) { create(:survivor) }

  context 'Validate location relation' do
    it 'Location is valid' do
      params = { longitude: '200', latitude: '300' }

      location = survivor.build_location(params)

      expect(location).to be_valid
    end

    it 'logitude is invalid, because is required' do
      params = { latitude: '200' }

      location = survivor.build_location(params)

      expect(location).to_not be_valid
    end
  end

  context 'Validate survivor gender attribute' do
    it 'Location is valid' do
      params = { longitude: '200', latitude: '300' }

      location = survivor.build_location(params)

      expect(location).to be_valid
    end

    it 'latitude is invalid, because is required' do
      params = { longitude: '200' }

      location = survivor.build_location(params)

      expect(location).to_not be_valid
    end
  end
end
