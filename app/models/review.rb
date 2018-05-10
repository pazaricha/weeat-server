# == Schema Information
#
# Table name: reviews
#
#  id            :bigint(8)        not null, primary key
#  comment       :text
#  rating        :integer
#  reviewer_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint(8)
#
# Indexes
#
#  index_reviews_on_restaurant_id  (restaurant_id)
#

class Review < ApplicationRecord
  validates :restaurant_id, :rating, :reviewer_name, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  belongs_to :restaurant

  after_create :recalculate_restaurant_ratings
  after_destroy :recalculate_restaurant_ratings

  private

  def recalculate_restaurant_ratings
    restaurant.recalculate_ratings!
  end
end
