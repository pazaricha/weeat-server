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
#

class Restaurant < ApplicationRecord
  validates :name, :address, :cuisine, :maximum_delivery_time, presence: true
  validates :name, uniqueness: { scope: :address,
    message: "can't have 2 restaurants with the same name in the same address" }, on: :create
  validates :rating, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  has_many :reviews
  has_one :zomato_metadata

  def recalculate_ratings!
    self.rating = if zomato_metadata.present? && zomato_metadata.votes > 0
                    ((zomato_metadata.votes * zomato_metadata.rating) + (reviews.sum(:rating) * reviews.size)) / (zomato_metadata.votes + reviews.size)
                  elsif reviews.present?
                    reviews.sum(:rating) / BigDecimal(reviews.size)
                  else
                    0
                  end

    save!
  end
end
