require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  context 'PUT #update' do
    let!(:survivor) { create(:survivor) }

    it 'should update location info' do
      params = { longitude: -12.231234, latitude: 32.2323 }

      put :update, params: { id: survivor[:id], location: params }
      survivor.reload

      expect(response).to have_http_status(200)
      expect(survivor.location[:longitude]).to eq(params[:longitude])
      expect(survivor.location[:latitude]).to eq(params[:latitude])
    end
  end

  context 'GET #fetch_closest_survivor' do
    let!(:survivor) { create(:survivor, :main) }
    let!(:survivors) { create_list(:survivor, 4) }

    it 'should retrive closest survivor on longitude' do
      get :retrieve_closest_survivor, params: { id: survivor[:id], search_by: 'longitude' }

      expect(response).to have_http_status(200)
    end

    it 'should retrive closest survivor on latitude' do
      get :retrieve_closest_survivor, params: { id: survivor[:id], search_by: 'latitude' }

      expect(response).to have_http_status(200)
    end

    it 'should retrive closest survivor inline' do
      get :retrieve_closest_survivor, params: { id: survivor[:id], search_by: 'inline' }
      
      expect(response).to have_http_status(200)
    end
  end
end
