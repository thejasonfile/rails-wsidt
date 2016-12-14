class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_id
      t.string :title
      t.string :description
      t.string :start_time
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
