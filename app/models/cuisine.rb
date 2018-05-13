# == Schema Information
#
# Table name: cuisines
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cuisines_on_name  (name) UNIQUE
#

class Cuisine < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
