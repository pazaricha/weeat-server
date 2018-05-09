require 'zomato/syncer'
require 'rails_helper'

RSpec.describe Zomato::Syncer do
  let(:example_restaurants) { JSON.parse(File.read('spec/support/sample_restaurants_transformed.json')).each(&:symbolize_keys!) }

  subject { Zomato::Syncer.new(example_restaurants) }

  describe :sync do
    it "calls 'sync_restaurant' on each restaurant_hash" do
      expect(subject).to receive(:sync_restaurant).exactly(2).times

      subject.sync
    end
  end

  describe :sync_restaurant do
    let(:example_restaurants_hash) { example_restaurants.first }

    context 'when a restaurant with the same zomato_restaurant_id does not exist' do
      it 'creates it' do
        expect{ subject.send(:sync_restaurant, example_restaurants_hash) }.to change{ Restaurant.all.size }.from(0).to(1)
      end
    end

    context 'when a restaurant with the same zomato_restaurant_id exists' do
      it "updates it's attributes" do
        moshe_restaurant = create(:restaurant, zomato_restaurant_id: example_restaurants_hash[:zomato_restaurant_id], name: 'Moshe restaurant')

        expect{ subject.send(:sync_restaurant, example_restaurants_hash) }.not_to change{ Restaurant.all.size }

        expect(moshe_restaurant.reload.name).to eq(example_restaurants_hash[:name])
      end
    end

  end
end