require 'zomato/client'
require 'zomato/syncer'

desc 'import/sync restaurants for a given "zomato city_id", default to NYC'
task :import_restaurants_from_zomato, [:city_id] => [:environment] do |_t, args|
  city_id = args[:city_id]

  puts 'importing restaurants from zomato...'

  restaurants_hashes = Zomato::Client.new(city_id: city_id).search_restaurants
  binding.pry
  puts 'restaurants imported, syncing started...'

  Zomato::Syncer.new(restaurants_hashes).sync

  puts 'syncning done, now randomly setting 25 restaurants "tenbis" to true'

  random_25_restaurants_ids = Restaurant.all.limit(100).pluck(:id).sample(25)
  Restaurant.where(id: random_25_restaurants_ids).update_all(tenbis: true)

  puts 'Done!'
end
