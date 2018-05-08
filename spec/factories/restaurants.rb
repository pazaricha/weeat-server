FactoryBot.define do
  factory :restaurant do
    name { "#{Faker::Company.name} #{Faker::Dessert.topping}" }
    cuisine { ['American', 'Asian', 'BBQ', 'Fast Food', 'Pizza'].sample }
    rating { BigDecimal(rand(0.0..5.0).to_s).round(1) }
    tenbis { [true, false].sample }
    address { "#{Faker::Address.street_address} #{Faker::Address.street_suffix}, #{Faker::Address.city} #{Faker::Address.zip_code}" }
    maximum_delivery_time { ENV['delivery_times'].split(', ').sample }
  end
end
