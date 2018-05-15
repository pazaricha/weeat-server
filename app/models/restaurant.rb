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
#  cuisine_id            :integer
#

class Restaurant < ApplicationRecord
  validates :name, :address, :cuisine_id, :maximum_delivery_time, presence: true
  validates :name, uniqueness: { scope: :address,
    message: "can't have 2 restaurants with the same name in the same address" }, on: :create
  validates :rating, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  has_many :reviews
  has_one :zomato_metadata, dependent: :destroy
  belongs_to :cuisine

  def recalculate_rating!
    update(rating: RatingCalculator.new(id).calculate)
  end
end
