require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe :recalculate_ratings! do
    context 'when it has no zomato_rating or weeat_rating' do
      context 'and when it previously had weeat_rating' do
        let(:restaurant_with_reviews) { create(:restaurant) }

        it 'resets the weeat_rating and rating back to 0' do
          review_for_restaurant = create(:review, restaurant: restaurant_with_reviews, rating: 2)

          expect(restaurant_with_reviews.reload.weeat_rating).to eq(2)
          expect(restaurant_with_reviews.rating).to eq(2)

          review_for_restaurant.destroy

          expect(restaurant_with_reviews.reload.weeat_rating).to eq(0)
          expect(restaurant_with_reviews.rating).to eq(0)
        end
      end
    end

    context 'when it has both zomato_rating or weeat_rating' do
      let(:restaurant_with_zomato_rating_and_reviews) { create(:restaurant, zomato_rating: 3) }

      it 'recalculates the weeat_rating and the rating with the zomato_rating' do
        create(:review, restaurant: restaurant_with_zomato_rating_and_reviews, rating: 2)
        create(:review, restaurant: restaurant_with_zomato_rating_and_reviews.reload, rating: 5)
        create(:review, restaurant: restaurant_with_zomato_rating_and_reviews.reload, rating: 1)

        expect(restaurant_with_zomato_rating_and_reviews.reload.weeat_rating).to eq(2.7)
        expect(restaurant_with_zomato_rating_and_reviews.reload.rating).to eq(2.9)
      end
    end

    context 'when it has only weeat_rating' do
      let(:restaurant_with_reviews) { create(:restaurant) }

      it 'recalculates the weeat_rating and sets rating to be the value of weeat_rating' do
        create(:review, restaurant: restaurant_with_reviews, rating: 4)
        create(:review, restaurant: restaurant_with_reviews.reload, rating: 5)

        expect(restaurant_with_reviews.reload.weeat_rating).to eq(4.5)
        expect(restaurant_with_reviews.rating).to eq(4.5)
      end
    end

    context 'when it has only zomato_rating' do
      let(:restaurant_with_zomato_rating) { create(:restaurant, zomato_rating: 3.6) }

      it 'sets the rating to the value of zomato_rating' do
        restaurant_with_zomato_rating.recalculate_ratings!

        expect(restaurant_with_zomato_rating.reload.rating).to eq(3.6)
      end
    end
  end
end
