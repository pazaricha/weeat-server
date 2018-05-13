FactoryBot.define do
  factory :restaurant do
    name { "#{Faker::Company.name} #{Faker::Dessert.topping}" }
    cuisine { ['American', 'Asian', 'BBQ', 'Fast Food', 'Pizza'].sample }
    tenbis { [true, false].sample }
    address { "#{Faker::Address.street_address} #{Faker::Address.street_suffix}, #{Faker::Address.city} #{Faker::Address.zip_code}" }
    maximum_delivery_time { ENV['DELIVERY_TIMES'].split(', ').sample }

    factory :restaurant_with_zomato_metadata do
      transient do
        zomato_restaurant_id 1
        zomato_rating { rand(0.0..5.0).round(1) }
        zomato_votes { rand(100..2000) }
      end

      after(:create) do |restaurant, evaluator|
        create(:zomato_metadata,
          restaurant: restaurant,
          zomato_restaurant_id: evaluator.zomato_restaurant_id,
          rating: evaluator.zomato_rating,
          votes: evaluator.zomato_votes
        )
      end
    end
  end
end
