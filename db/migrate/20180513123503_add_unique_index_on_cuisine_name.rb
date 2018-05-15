class AddUniqueIndexOnCuisineName < ActiveRecord::Migration[5.2]
  def change
    add_index :cuisines, :name, unique: true
  end
end
