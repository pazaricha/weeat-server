module Zomato
  class Client
    NEW_YORK_CITY_ID = 280

    attr_reader :restaurants

    def initialize(options = {})
      @restaurants = []
      @city_id = options[:city_id] || NEW_YORK_CITY_ID
      @api_key = options[:api_key] || ENV['ZOMATO_API_KEY']
    end

    def search_restaurants
      return restaurants if restaurants.present?

      [0, 20, 40, 60, 80].each do |start_offset|
        raw_restaurants = fetch(start_offset: start_offset)
        transform_and_populate(raw_restaurants)
      end

      restaurants
    end

    private

    def fetch(start_offset: 0)
      response = RestClient::Request.execute(
        method: :get,
        url: 'https://developers.zomato.com/api/v2.1/search',
        headers: {
          'user_key' => @api_key,
          params: { start: start_offset, count: 20, entity_id: @city_id, entity_type: 'city' }
        }
      )

      JSON.parse(response.body)['restaurants']
    end

    def transform_and_populate(raw_restaurants)
      raw_restaurants.each do |restaurant|
        real_restaurant = restaurant['restaurant']

        restaurants << {
          name: real_restaurant['name'],
          address: real_restaurant['location']['address'],
          maximum_delivery_time: ENV['DELIVERY_TIMES'].split(', ').sample,
          cuisine: real_restaurant['cuisines'].split(', ').first,
          meta_data: {
            zomato_restaurant_id: real_restaurant['id'],
            rating: real_restaurant['user_rating']['aggregate_rating'],
            votes: real_restaurant['user_rating']['votes']
          }
        }
      end
    end
  end
end
