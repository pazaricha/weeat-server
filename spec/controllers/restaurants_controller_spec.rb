require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all restaurants in the db' do
      create_list(:restaurant, 2)
      get :index
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      restaurant = create(:restaurant)

      get :show, params: { id: restaurant.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(restaurant.id)
    end
  end

  describe 'POST #create' do
    context 'when called with valid params' do
      let(:valid_restaurant_params) { attributes_for(:restaurant) }

      it "creates the restaurant and returns the 'created' status" do
        post :create, params: { restaurant: valid_restaurant_params }

        expect(response).to have_http_status(:created)
        expect(Restaurant.last.name).to eq(valid_restaurant_params[:name])
      end
    end

    context 'when called with invalid params' do
      let(:invalid_restaurant_params) { attributes_for(:restaurant, name: nil) }

      it "does not create the restaurant and returns the 'unprocessable_entity' status" do
        post :create, params: { restaurant: invalid_restaurant_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Restaurant.all.size).to eq(0)
      end
    end
  end
end
