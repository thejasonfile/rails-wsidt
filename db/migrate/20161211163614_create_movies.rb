class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.integer :tmsId
      t.string :title
      t.text :description
      t.text :genres, array: true, default: []
      t.text :showtimes, array: true, default: []
      t.string :image_url

      t.timestamps
    end
  end
end
