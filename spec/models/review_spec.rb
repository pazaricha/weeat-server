require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'callbacks' do
    describe 'after_create' do
      let(:restaurant) { create(:restaurant) }

      it 'calls "recalculate_ratings" on the restaurant' do
        expect(restaurant).to receive(:recalculate_ratings!)
        create(:review, restaurant: restaurant)
      end
    end
  end
end
