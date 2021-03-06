class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :rating, default: 0
      t.text :note, default: ''
      t.integer :favoritable_id
      t.string :favoritable_type

      t.timestamps
    end

    add_index :favorites, [:favoritable_type, :favoritable_id]
  end
end
