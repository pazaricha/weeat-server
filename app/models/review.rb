# == Schema Information
#
# Table name: reviews
#
#  id            :bigint(8)        not null, primary key
#  comment       :text
#  rating        :integer
#  reviwer_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint(8)
#
# Indexes
#
#  index_reviews_on_restaurant_id  (restaurant_id)
#

class Review < ApplicationRecord
  belongs_to :restaurant

  after_create :recalculate_restaurant_ratings

  private

  def recalculate_restaurant_ratings
    restaurant.recalculate_ratings!
  end
end
