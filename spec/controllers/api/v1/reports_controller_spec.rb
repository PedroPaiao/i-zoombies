require 'rails_helper'

RSpec.describe Api::V1::ReportsController, type: :controller do
  context 'PUT #create' do
    let!(:whistleblower_survivor) { create(:survivor, :main) }
    let!(:reported_survivor) { create(:survivor, :main) }

    it 'should create an report' do
      params = { description: 'I see!!', reported_survivor_id: reported_survivor[:id] }
      post :create, params: { id: whistleblower_survivor[:id], report: params }

      expect(response).to have_http_status(200)
    end
  end
end
