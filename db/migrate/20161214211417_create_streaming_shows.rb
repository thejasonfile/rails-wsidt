class CreateStreamingShows < ActiveRecord::Migration[5.0]
  def change
    create_table :streaming_shows do |t|
      t.string :show_id
      t.string :title
      t.string :first_aired
      t.string :image
      t.string :url
    end
  end
end
