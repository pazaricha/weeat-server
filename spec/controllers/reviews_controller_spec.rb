require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:restaurant_being_reviewed) { create(:restaurant) }

    context 'when called with valid params' do
      let(:valid_review_params) { attributes_for(:review) }

      it "creates the restaurant and returns the 'created' status" do
        expect(restaurant_being_reviewed.reviews.size).to eq(0)

        post :create, params: { restaurant_id: restaurant_being_reviewed.id, review: valid_review_params }

        expect(response).to have_http_status(:created)
        expect(restaurant_being_reviewed.reload.reviews.size).to eq(1)
      end
    end

    context 'when called with invalid params' do
      let(:invalid_review_params) { attributes_for(:review, rating: nil) }

      it "does not create the restaurant and returns the 'unprocessable_entity' status" do
        expect(restaurant_being_reviewed.reviews.size).to eq(0)

        post :create, params: { restaurant_id: restaurant_being_reviewed.id, review: invalid_review_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(restaurant_being_reviewed.reload.reviews.size).to eq(0)
      end
    end
  end
end
