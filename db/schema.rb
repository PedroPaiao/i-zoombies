# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_26_064320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "survivor_id"
    t.integer "lat_direction", default: 1
    t.integer "long_direction", default: 1
    t.index ["survivor_id"], name: "index_locations_on_survivor_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "description"
    t.bigint "whistleblower_survivor_id"
    t.bigint "reported_survivor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reported_survivor_id"], name: "index_reports_on_reported_survivor_id"
    t.index ["whistleblower_survivor_id"], name: "index_reports_on_whistleblower_survivor_id"
  end

  create_table "survivors", force: :cascade do |t|
    t.string "name"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "infected", default: false
  end

  add_foreign_key "locations", "survivors", on_delete: :cascade
  add_foreign_key "reports", "survivors", column: "reported_survivor_id"
  add_foreign_key "reports", "survivors", column: "whistleblower_survivor_id"
end
