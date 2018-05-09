require 'zomato/client'
require 'zomato/syncer'

desc 'import/sync restaurants for a given "zomato city_id", default to NYC'
task :import_restaurants_from_zomato, [:city_id] => [:environment] do |_t, args|
  city_id = args[:city_id]

  puts 'importing restaurants from zomato...'

  restaurants_hashes = Zomato::Client.new(city_id: city_id).search_restaurants

  puts "restaurants imported, syncing started..."

  Zomato::Syncer.new(restaurants_hashes).sync

  puts 'Done!'
end
