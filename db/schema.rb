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

ActiveRecord::Schema.define(version: 20180522004245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deeds", force: :cascade do |t|
    t.string   "identifier"
    t.integer  "state",                default: 0
    t.date     "start_date"
    t.integer  "duration"
    t.integer  "real_estate_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "new_authorized_email"
    t.index ["real_estate_id", "identifier"], name: "index_deeds_on_real_estate_id_and_identifier", unique: true, using: :btree
    t.index ["real_estate_id"], name: "index_deeds_on_real_estate_id", using: :btree
  end

  create_table "deeds_users", id: false, force: :cascade do |t|
    t.integer "deed_id", null: false
    t.integer "user_id", null: false
    t.index ["deed_id", "user_id"], name: "index_deeds_users_on_deed_id_and_user_id", using: :btree
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "deed_id"
    t.datetime "executed_on"
    t.integer  "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["deed_id", "state"], name: "index_steps_on_deed_id_and_state", unique: true, using: :btree
    t.index ["deed_id"], name: "index_steps_on_deed_id", using: :btree
    t.index ["user_id"], name: "index_steps_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "job"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "steps", "deeds"
  add_foreign_key "steps", "users"
end
