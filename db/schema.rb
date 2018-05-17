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

ActiveRecord::Schema.define(version: 2018_05_17_102245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cuisines_on_name", unique: true
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.decimal "rating", precision: 2, scale: 1, default: "0.0"
    t.boolean "tenbis", default: false
    t.text "address"
    t.integer "maximum_delivery_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cuisine_id"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "reviewer_name"
    t.integer "rating"
    t.text "comment"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
  end

  create_table "zomato_metadata", force: :cascade do |t|
    t.decimal "rating", precision: 2, scale: 1, default: "0.0"
    t.integer "votes", default: 0
    t.integer "zomato_restaurant_id"
    t.integer "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_zomato_metadata_on_restaurant_id", unique: true
  end

end
