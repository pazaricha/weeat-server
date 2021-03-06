require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'callbacks' do
    let(:restaurant) { create(:restaurant) }

    describe 'after_create' do
      it 'calls "recalculate_rating!" on the restaurant' do
        expect(restaurant).to receive(:recalculate_rating!)
        create(:review, restaurant: restaurant)
      end
    end

    describe 'after_destroy' do
      it 'calls "recalculate_rating!" on the restaurant' do
        review = create(:review, restaurant: restaurant)
        expect(restaurant).to receive(:recalculate_rating!)
        review.destroy
      end
    end
  end
end
