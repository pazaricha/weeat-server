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
#  weeat_rating          :decimal(2, 1)    default(0.0)
#  zomato_rating         :decimal(2, 1)    default(0.0)
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
  validates :name, uniqueness: { scope: :address,
    message: "can't have 2 restaurants with the same name in the same address" }, on: :create
  validates :rating, :zomato_rating, :weeat_rating, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  has_many :reviews

  def recalculate_ratings!
    # return if reviews.blank?
    # all_reviews_average_rating = reviews.sum(:rating) / BigDecimal(reviews.size)

    # self.rating = (rating + all_reviews_average_rating) / 2

    # puts "rating: ***** #{rating}"

    # save!
  end
end
