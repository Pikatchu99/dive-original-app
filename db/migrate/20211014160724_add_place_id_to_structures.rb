class AddPlaceIdToStructures < ActiveRecord::Migration[6.0]
  def change
    add_column :structures, :place_id, :string
  end
end
