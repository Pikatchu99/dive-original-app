class CreateStructures < ActiveRecord::Migration[6.0]
  def change
    create_table :structures do |t|
      t.string :name
      t.string :contact
      t.string :email
      t.string :variety

      t.timestamps
    end
  end
end
