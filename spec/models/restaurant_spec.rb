require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe :recalculate_ratings! do
    let(:restaurant) { create(:restaurant, rating: 3) }

    it "recalculates the restaurant's average rating and saves it" do
      create(:review, restaurant: restaurant, rating: 2)
      create(:review, restaurant: restaurant, rating: 5)
      a = build(:review, restaurant: restaurant, rating: 1)

      restaurant.recalculate_ratings!
      expect(restaurant.rating).to eq(2.8)
    end
  end
end
