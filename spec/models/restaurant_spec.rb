require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe :recalculate_ratings! do
    context 'when it has rating from zomato or from reviews' do
      context 'and when it previously had reviews' do
        let(:restaurant_with_reviews) { create(:restaurant) }

        it 'resets the rating back to 0' do
          review_for_restaurant = create(:review, restaurant: restaurant_with_reviews, rating: 2)

          expect(restaurant_with_reviews.rating).to eq(2)

          review_for_restaurant.destroy

          expect(restaurant_with_reviews.rating).to eq(0)
        end
      end
    end

    context 'when it has both rating from zomato and from reviews' do
      let(:restaurant_with_zomato_rating_and_reviews) { create(:restaurant_with_zomato_metadata, zomato_rating: 3, zomato_votes: 50) }

      it 'recalculates the rating with the rating from zomato and from reviews' do
        create(:review, restaurant: restaurant_with_zomato_rating_and_reviews, rating: 2)
        create(:review, restaurant: restaurant_with_zomato_rating_and_reviews.reload, rating: 5)

        expect(restaurant_with_zomato_rating_and_reviews.reload.rating).to eq(3.2)
      end
    end

    context 'when it has only rating from reviews' do
      let(:restaurant_with_reviews) { create(:restaurant) }

      it 'recalculates the rating from the reviews' do
        create(:review, restaurant: restaurant_with_reviews, rating: 4)
        create(:review, restaurant: restaurant_with_reviews.reload, rating: 5)

        expect(restaurant_with_reviews.rating).to eq(4.5)
      end
    end

    context 'when it has only zomato_rating' do
      let(:restaurant_with_zomato_rating) { create(:restaurant_with_zomato_metadata, zomato_rating: 3) }

      it 'sets the rating to the value of zomato_rating' do
        restaurant_with_zomato_rating.recalculate_ratings!

        expect(restaurant_with_zomato_rating.reload.rating).to eq(3)
      end
    end
  end
end
