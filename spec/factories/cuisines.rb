FactoryBot.define do
  factory :cuisine do
    name { ['American', 'Asian', 'BBQ', 'Fast Food', 'Pizza'].sample }
  end
end
