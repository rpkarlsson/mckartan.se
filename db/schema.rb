# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150610072707) do

  create_table "points", force: :cascade do |t|
    t.integer "section_id", null: false
    t.float   "lng"
    t.float   "lat"
  end

  add_index "points", ["section_id"], name: "index_points_on_section_id"

  create_table "sections", force: :cascade do |t|
    t.integer  "user_id",                  null: false
    t.decimal  "distance",                 null: false
    t.decimal  "duration",                 null: false
    t.string   "start_address", limit: 50, null: false
    t.string   "end_address",   limit: 50, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users_engine_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
