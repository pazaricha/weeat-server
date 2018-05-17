class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :address, :latitude, :longitude,
    :maximum_delivery_time, :name, :rating, :tenbis

  belongs_to :cuisine
end
