class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :cuisine
      t.decimal :rating, precision: 2, scale: 1, default: 0.0
      t.boolean :tenbis, default: false
      t.text :address
      t.integer :maximum_delivery_time

      t.timestamps
    end
  end
end
