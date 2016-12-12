class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.string :concert_id
      t.datetime :start_time
      t.text :venue, array: true, default: []
      t.string :artist
      t.string :ticket_url

      t.timestamps
    end
  end
end
