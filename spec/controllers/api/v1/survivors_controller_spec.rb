require 'rails_helper'

RSpec.describe Api::V1::SurvivorsController, type: :controller do
  context 'GET #index' do
    it 'should success and retrieve survivors' do
      get :index

      expect(response).to have_http_status(200)
    end
  end
end
