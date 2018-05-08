require 'zomato/client';

if Restaurant.all.size == 0
  puts "importing restaurants from zomato for the first time..."

  restaurants = Zomato::Client.new.fetch_restaurants
  restaurants.each do |restaurant|
    Restaurant.create!(restaurant)
  end

  puts "Done!"
end