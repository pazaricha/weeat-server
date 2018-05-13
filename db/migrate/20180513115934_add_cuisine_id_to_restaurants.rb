class AddCuisineIdToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :cuisine_id, :integer
  end
end
