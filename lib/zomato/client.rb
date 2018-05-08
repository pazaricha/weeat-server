module Zomato
  class Client
    NEW_YORK_CITY_ID = 280

    attr_reader :restaurants

    def initialize(options = {})
      @restaurants = []
      @city_id = options[:city_id] || NEW_YORK_CITY_ID
    end

    def fetch_restaurants
      return @restaurants if @restaurants.present?

      [0, 20, 40, 60, 80].each do |start_offset|
        response = RestClient::Request.execute(
          method: :get,
          url: 'https://developers.zomato.com/api/v2.1/search',
          headers: {
            'user_key' => ENV['zomato_api_key'],
            params: { start: start_offset, count: 20, entity_id: @city_id, entity_type: 'city' }
          }
        )
        temp_restaurants = JSON.parse(response.body)['restaurants']

        temp_restaurants.each do |restaurant|
          real_restaurant = restaurant['restaurant']
          @restaurants << {
            zomato_restaurant_id: real_restaurant['id'],
            name: real_restaurant['name'],
            address: real_restaurant['location']['address'],
            maximum_delivery_time: ENV['delivery_times'].split(', ').sample,
            cuisine: real_restaurant['cuisines'].split(', ').first,
            rating: real_restaurant['user_rating']['aggregate_rating'],
            tenbis: [true, false].sample
          }
        end
      end

      @restaurants
    end
  end
end
