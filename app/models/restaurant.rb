# == Schema Information
#
# Table name: restaurants
#
#  id                    :bigint(8)        not null, primary key
#  address               :text
#  cuisine               :string
#  maximum_delivery_time :integer
#  name                  :string
#  rating                :decimal(2, 1)    default(0.0)
#  tenbis                :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  zomato_restaurant_id  :integer
#
# Indexes
#
#  index_restaurants_on_zomato_restaurant_id  (zomato_restaurant_id)
#

class Restaurant < ApplicationRecord
  validates :name, :address, :cuisine, :maximum_delivery_time, presence: true
  validates :rating, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
