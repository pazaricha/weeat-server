require 'zomato/syncer'
require 'rails_helper'

RSpec.describe Zomato::Syncer do
  let(:example_restaurants) do
    resturants_transformed = JSON.parse(File.read('spec/support/sample_restaurants_transformed.json'))

    resturants_transformed.each do |restaurant|
      restaurant.symbolize_keys!
      restaurant[:meta_data].symbolize_keys!
    end
  end

  subject { Zomato::Syncer.new(example_restaurants) }

  describe :sync do
    it "calls 'sync_restaurant' on each restaurant_hash" do
      expect(subject).to receive(:sync_restaurant).exactly(2).times

      subject.sync
    end
  end

  describe :find_or_create_cuisine_and_update_restaurant_hash do
    let(:example_restaurants_hash) { example_restaurants.first }

    context 'when a cuisine with the same name already exists' do
      it 'find the cuisine and update the restaurant hash to have a cuisine_id key instead of cuisine key' do
        existing_cuisine = create(:cuisine, name: example_restaurants_hash[:cuisine])

        expect{ subject.send(:find_or_create_cuisine_and_update_restaurant_hash, example_restaurants_hash) }.not_to change{ Cuisine.all.size }

        expect(example_restaurants_hash[:cuisine]).to be_nil
        expect(example_restaurants_hash[:cuisine_id]).to eq(existing_cuisine.id)
      end
    end

    context 'when a cuisine with the same name does not exist' do
      it 'creates the cuisine and update the restaurant hash appropriately' do
        expect{ subject.send(:find_or_create_cuisine_and_update_restaurant_hash, example_restaurants_hash) }.to change{ Cuisine.all.size }.from(0).to(1)

        expect(example_restaurants_hash[:cuisine]).to be_nil
        expect(example_restaurants_hash[:cuisine_id]).to be_present
      end
    end
  end

  describe :sync_restaurant do
    let(:example_restaurants_hash) { example_restaurants.first }

    before(:each) do
      subject.send(:find_or_create_cuisine_and_update_restaurant_hash, example_restaurants_hash)
    end

    context 'when a restaurant with the same zomato_restaurant_id does not exist' do
      it 'creates the restaurant' do
        expect{ subject.send(:sync_restaurant, example_restaurants_hash) }.to change{ Restaurant.all.size }.from(0).to(1)
      end

      it 'creates the zomato_metadata for the restaurant' do
        expect{ subject.send(:sync_restaurant, example_restaurants_hash) }.to change{ ZomatoMetadata.all.size }.from(0).to(1)
      end
    end

    context 'when a restaurant with the same zomato_restaurant_id exists' do
      it'updates the restauran' do
        moshe_restaurant = create(:restaurant_with_zomato_metadata, name: 'Moshe restaurant', zomato_restaurant_id: example_restaurants_hash[:meta_data][:zomato_restaurant_id])

        expect{ subject.send(:sync_restaurant, example_restaurants_hash) }.not_to change{ Restaurant.all.size }

        expect(moshe_restaurant.reload.name).to eq(example_restaurants_hash[:name])
      end

      it "updates the restaurant's zomato_metadata" do
        expected_rating = BigDecimal(example_restaurants_hash[:meta_data][:rating])

        restaurant = create(:restaurant_with_zomato_metadata, zomato_restaurant_id: example_restaurants_hash[:meta_data][:zomato_restaurant_id], zomato_rating: 3)

        expect{ subject.send(:sync_restaurant, example_restaurants_hash) }.not_to change{ ZomatoMetadata.all.size }

        expect(restaurant.reload.zomato_metadata.rating).to eq(expected_rating)
      end
    end

  end
end