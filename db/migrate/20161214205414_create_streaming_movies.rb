class CreateStreamingMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :streaming_movies do |t|
      t.string :movie_id
      t.string :title
      t.string :release_date
      t.string :rating
      t.string :image
      t.string :url

      t.timestamps
    end
  end
end
