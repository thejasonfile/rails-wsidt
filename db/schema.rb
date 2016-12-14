# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161214130113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bars", force: :cascade do |t|
    t.string   "yelp_id"
    t.string   "name"
    t.string   "rating"
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "url"
    t.string   "phone"
    t.string   "rating_image"
    t.string   "image"
    t.text     "categories",   default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "concerts", force: :cascade do |t|
    t.string   "concert_id"
    t.string   "start_time"
    t.string   "venue_name"
    t.string   "venue_address"
    t.string   "venue_city"
    t.string   "artist"
    t.string   "ticket_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_id"
    t.string   "title"
    t.string   "description"
    t.string   "start_time"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rating",           default: 0
    t.text     "note",             default: ""
    t.integer  "favoritable_id"
    t.string   "favoritable_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable_type_and_favoritable_id", using: :btree
  end

  create_table "movies", force: :cascade do |t|
    t.string   "tmsId"
    t.string   "title"
    t.text     "description"
    t.text     "genres",      default: [],              array: true
    t.text     "showtimes",   default: [],              array: true
    t.string   "image_url"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "yelp_id"
    t.string   "name"
    t.string   "rating"
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "url"
    t.string   "phone"
    t.string   "rating_image"
    t.string   "image"
    t.text     "categories",   default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
