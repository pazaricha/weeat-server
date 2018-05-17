require 'rails_helper'

RSpec.describe RatingCalculator do
  let(:restaurant) { create(:restaurant) }
  subject { RatingCalculator }

  describe :calculate do
    context 'when it has no zomato_metadata or reviews' do
      it 'return 0' do
        expect(subject.calculate(restaurant)).to eq(0)
      end
    end

    context 'when it has either zomato_metadata or reviews' do
      let(:restaurant) { create(:restaurant_with_zomato_metadata, zomato_rating: 3, zomato_votes: 50) }

      it 'returns the weighted average rating from both' do
        create(:review, restaurant: restaurant, rating: 2)
        create(:review, restaurant: restaurant, rating: 5)

        expect(subject.calculate(restaurant)).to eq(3.2)
      end
    end
  end
end
