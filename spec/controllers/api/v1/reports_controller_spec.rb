require 'rails_helper'

RSpec.describe Api::V1::ReportsController, type: :controller do
  context 'PUT #create' do
    let!(:whistleblower_survivor) { create(:survivor, :main) }
    let!(:reported_survivor) { create(:survivor, :main) }

    let!(:close_infected_suvivor) { create(:survivor, :close_infected_suvivor) }

    it 'should create an report' do
      params = { description: 'I see!!', reported_survivor_id: reported_survivor[:id] }
      post :create, params: { id: whistleblower_survivor[:id], report: params }

      expect(response).to have_http_status(200)
    end

    it 'should create an report and mark the infected survivor' do
      params = { description: 'I see!!', reported_survivor_id: close_infected_suvivor[:id] }

      expect(close_infected_suvivor[:infected]).to be_falsey

      post :create, params: { id: whistleblower_survivor[:id], report: params }
      close_infected_suvivor.reload

      expect(response).to have_http_status(200)
      expect(close_infected_suvivor[:infected]).to be_truthy
    end
  end

  context 'GET #complaints_about_me' do
    let(:suvivor) { create(:survivor, :main) }
    let(:report) { create(:report) }

    it 'should array empty of survivors' do
      get :complaints_about_me, params: { id: suvivor[:id] }

      expect(response).to have_http_status(200)
      expect(assigns(:reports)).to be_empty
    end

    it 'should array empty of survivors' do
      get :complaints_about_me, params: { id: report.reported_survivor[:id] }

      expect(response).to have_http_status(200)
      expect(assigns(:reports)).to_not be_empty
    end
  end

  context 'GET #my_complaints' do
    let(:suvivor) { create(:survivor, :main) }
    let(:report) { create(:report) }

    it 'should array empty of survivors' do
      get :my_complaints, params: { id: suvivor[:id] }

      expect(response).to have_http_status(200)
      expect(assigns(:reports)).to be_empty
    end

    it 'should array empty of survivors' do
      get :my_complaints, params: { id: report.whistleblower_survivor[:id] }

      expect(response).to have_http_status(200)
      expect(assigns(:reports)).to_not be_empty
    end
  end
end
