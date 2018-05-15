# == Schema Information
#
# Table name: zomato_metadata
#
#  id                   :bigint(8)        not null, primary key
#  rating               :decimal(2, 1)    default(0.0)
#  votes                :integer          default(0)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  restaurant_id        :integer
#  zomato_restaurant_id :integer
#
# Indexes
#
#  index_zomato_metadata_on_restaurant_id  (restaurant_id) UNIQUE
#

class ZomatoMetadata < ApplicationRecord
  validates :restaurant_id, presence: true, uniqueness: true
  validates :rating, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :zomato_restaurant_id, presence: true

  belongs_to :restaurant
end
