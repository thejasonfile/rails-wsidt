class AddZipcodeToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :zipcode, :string
  end
end
