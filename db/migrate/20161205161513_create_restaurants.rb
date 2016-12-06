class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :yelp_id
      t.string :name
      t.string :rating
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :url
      t.string :phone

      t.timestamps
    end
  end
end
