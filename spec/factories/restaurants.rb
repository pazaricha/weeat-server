FactoryBot.define do
  factory :restaurant do
    name { "#{Faker::Company.name} #{Faker::Dessert.topping}" }
    cuisine { ['American', 'Asian', 'BBQ', 'Fast Food', 'Pizza'].sample }
    tenbis { [true, false].sample }
    address { "#{Faker::Address.street_address} #{Faker::Address.street_suffix}, #{Faker::Address.city} #{Faker::Address.zip_code}" }
    maximum_delivery_time { ENV['delivery_times'].split(', ').sample }
  end
end
