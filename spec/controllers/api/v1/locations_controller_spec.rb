require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  context 'PUT #update' do
    let!(:survivor) { create(:survivor) }
    let!(:location) { create(:location, survivor: survivor) }

    it 'should update location info' do
      params = { longitude: '-12.231234', latitude: '32.2323' }

      put :update, params: { id: survivor[:id], location: params }

      expect(response).to have_http_status(200)
    end
  end
end
