FactoryBot.define do
  factory :zomato_metadata do
    rating { rand(0.0..5.0).round(1) }
    votes 1
    zomato_restaurant_id 1
    restaurant
  end
end
