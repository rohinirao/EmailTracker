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

ActiveRecord::Schema[8.0].define(version: 2025_01_14_144350) do
  create_table "download_hits", force: :cascade do |t|
    t.integer "email_tracking_id", null: false
    t.string "user_agent", null: false
    t.string "ip_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_tracking_id"], name: "index_download_hits_on_email_tracking_id"
  end

  create_table "email_trackings", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "message_id", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_email_trackings_on_message_id", unique: true
    t.index ["uuid"], name: "index_email_trackings_on_uuid", unique: true
  end

  add_foreign_key "download_hits", "email_trackings"
end
