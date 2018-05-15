FactoryBot.define do
  factory :review do
    reviewer_name { Faker::Name.name }
    rating { rand(0..5) }
    comment { Faker::Lorem.paragraph }
    restaurant
  end
end
