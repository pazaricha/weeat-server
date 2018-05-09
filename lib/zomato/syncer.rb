module Zomato
  class Syncer

    def initialize(restaurants)
      @restaurants = restaurants
    end

    def sync
      @restaurants.each do |restaurant_hash|
        sync_restaurant(restaurant_hash)
      end
    end

    private

    def sync_restaurant(restaurant_hash)
      existing_restaurant = Restaurant.find_by(zomato_restaurant_id: restaurant_hash[:zomato_restaurant_id])

      if existing_restaurant.present?
        existing_restaurant.update!(restaurant_hash.except(:tenbis))
        existing_restaurant.recalculate_ratings!
      else
        new_restaurant = Restaurant.create!(restaurant_hash)
        new_restaurant.recalculate_ratings!
      end
    end
  end
end
