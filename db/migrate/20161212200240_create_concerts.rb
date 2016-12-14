class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.string :concert_id
      t.string :start_time
      t.string :venue_name
      t.string :venue_address
      t.string :venue_city
      t.string :artist
      t.string :ticket_url

      t.timestamps
    end
  end
end
