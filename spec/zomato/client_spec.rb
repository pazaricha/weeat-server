require 'zomato/client'
require 'rails_helper'

RSpec.describe Zomato::Client do
  subject { Zomato::Client.new }

  describe :search_restaurants do
    it 'returns an array of 100 transformed restaurant from zomato', :vcr do
      expect(subject.restaurants.size).to eq(0)

      expect(subject.search_restaurants.size).to eq(100)
    end
  end

  describe :fetch do
    it 'calls the zomato restaurants api and returns parsed json results', :vcr do
      raw_restaurants = subject.send(:fetch)
      expect(raw_restaurants).to be_instance_of(Array)
      expect(raw_restaurants).not_to be_empty
    end
  end

  describe :transform_and_populate do
    let(:example_resturants_raw) { JSON.parse(File.read('spec/support/sample_restaurants_raw.json')) }
    let(:example_resturants_transformed) { JSON.parse(File.read('spec/support/sample_restaurants_transformed.json')).each(&:symbolize_keys!) }

    it "transforms the elements of the raw resturants array and populates the class's restaurants array" do
      expect(example_resturants_raw.size).to eq(2)
      expect(subject.restaurants.size).to eq(0)

      subject.send(:transform_and_populate, example_resturants_raw)

      expect(subject.restaurants.size).to eq(2)
      expect(subject.restaurants).to eq(example_resturants_transformed)
    end
  end
end
