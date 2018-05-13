module Zomato
  class Syncer
    def initialize(restaurants)
      @restaurants = restaurants
    end

    def sync
      @restaurants.each do |restaurant_hash|
        find_or_create_cuisine_and_update_restaurant_hash(restaurant_hash)
        sync_restaurant(restaurant_hash)
      end
    end

    private

    def find_or_create_cuisine_and_update_restaurant_hash(restaurant_hash)
      cuisine_name = restaurant_hash.delete(:cuisine)
      cuisine = Cuisine.find_or_create_by!(name: cuisine_name)
      restaurant_hash.merge!(cuisine_id: cuisine.id)
    end

    def sync_restaurant(restaurant_hash)
      zomato_metadata = restaurant_hash.delete(:meta_data)

      existing_restaurant = Restaurant.joins(:zomato_metadata).where(zomato_metadata: { zomato_restaurant_id: zomato_metadata[:zomato_restaurant_id] }).first

      if existing_restaurant.present?
        update_restaurant_and_metadata(existing_restaurant, restaurant_hash, zomato_metadata)
      else
        create_restaurant_and_metadata(restaurant_hash, zomato_metadata)
      end
    end

    def create_restaurant_and_metadata(restaurant_hash, zomato_metadata)
      Restaurant.transaction do
        new_restaurant = Restaurant.create!(restaurant_hash)
        ZomatoMetadata.create!(zomato_metadata.merge(restaurant_id: new_restaurant.id))
        new_restaurant.recalculate_ratings!
      end
    end

    def update_restaurant_and_metadata(existing_restaurant, restaurant_hash, zomato_metadata)
      Restaurant.transaction do
        existing_restaurant.update!(restaurant_hash)
        existing_restaurant.zomato_metadata.update!(zomato_metadata)
        existing_restaurant.recalculate_ratings!
      end
    end
  end
end
