class CreateBars < ActiveRecord::Migration[5.0]
  def change
    create_table :bars do |t|
      t.string :yelp_id
      t.string :name
      t.string :rating
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :url
      t.string :phone
      t.string :rating_image
      t.string :image
      t.text :categories, array: true, default: []

      t.timestamps
    end
  end
end
