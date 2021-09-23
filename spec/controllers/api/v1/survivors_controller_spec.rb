require 'rails_helper'

RSpec.describe Api::V1::SurvivorsController, type: :controller do
  context 'GET #index' do
    it 'should success' do
      get :index

      expect(response).to have_http_status(200)
    end

    it 'should array empty of survivors' do
      get :index

      expect(assigns(:survivors)).to be_empty
    end

    it 'should array have one survivor' do
      create(:survivor)
      get :index

      expect(assigns(:survivors)).to_not be_empty
    end
  end

  context 'GET #show' do
    let(:survivor) { create(:survivor) }

    it 'should success' do
      get :show, params: { id: survivor[:id] }

      expect(response).to have_http_status(200)
    end

    it 'where have id' do
      get :show, params: { id: survivor[:id] }

      expect(assigns(:survivor)).to be_a(Survivor)
    end

    it 'where have same id' do
      get :show, params: { id: survivor[:id] }

      expect(assigns(:survivor)).to eq(survivor)
    end
  end
end
