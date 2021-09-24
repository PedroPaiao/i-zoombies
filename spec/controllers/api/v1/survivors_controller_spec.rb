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

  context 'POST #create' do
    let!(:params) do
      { name: 'Pedro Augusto', gender: :male }
    end

    it 'create new survivor' do
      post :create, params: { survivor: params }

      expect(response).to have_http_status(201)
    end

    it 'not create new survivor' do
      params = { name: 'Pedro Augusto' }
      post :create, params: { survivor: params }

      expect(response).to have_http_status(422)
      expect(assigns(:survivor)).to_not be_persisted
    end
  end

  context 'PUT #update' do
    let!(:survivor) { create(:survivor) }

    it 'should update survivor info' do
      params = { name: 'Pedro Paião' }

      put :update, params: { id: survivor[:id], survivor: params }
      survivor.reload

      expect(response).to have_http_status(200)
      expect(survivor[:name]).to eq('Pedro Paião')
    end

    it 'should not update survivor info' do
      initial_name = survivor[:name]
      params = { name: '' }

      put :update, params: { id: survivor[:id], survivor: params }
      survivor.reload

      expect(response).to have_http_status(422)
      expect(survivor[:name]).to eq(initial_name)
    end
  end

  context 'DELETE #destroy' do
    let!(:survivor) { create(:survivor) }

    it 'should delete survivor' do
      delete :destroy, params: { id: survivor[:id] }

      expect(response).to have_http_status(200)
      expect { survivor.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
