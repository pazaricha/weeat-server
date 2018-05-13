require 'rails_helper'

RSpec.describe CuisinesController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all cuisines in the db' do
      create_list(:cuisine, 5)
      get :index
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end
end
