FactoryBot.define do
  sequence :cuisine_name do |n|
    ['American', 'Asian', 'BBQ', 'Fast Food', 'Pizza'].sample + n.to_s
  end

  factory :cuisine do
    name { generate(:cuisine_name) }
  end
end
