FactoryBot.define do
  sequence :cuisine_name do |n|
    ['American', 'Asian', 'BBQ', 'Fast Food', 'Pizza'].sample + "#{n}"
  end

  factory :cuisine do
    name { generate(:cuisine_name) }
  end
end
