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

ActiveRecord::Schema.define(version: 20150426080624) do

  create_table "asset_categories", force: :cascade do |t|
    t.string "name", limit: 32
  end

  add_index "asset_categories", ["name"], name: "index_asset_categories_on_name", unique: true, using: :btree

  create_table "assets", force: :cascade do |t|
    t.string  "description",       limit: 32
    t.integer "room_id",           limit: 4
    t.integer "asset_category_id", limit: 4
  end

  add_index "assets", ["asset_category_id"], name: "index_assets_on_asset_category_id", using: :btree
  add_index "assets", ["room_id"], name: "index_assets_on_room_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at"
    t.text     "description",       limit: 65535
    t.integer  "room_id",           limit: 4
    t.integer  "asset_category_id", limit: 4
    t.integer  "asset_id",          limit: 4
  end

  add_index "reports", ["asset_category_id"], name: "index_reports_on_asset_category_id", using: :btree
  add_index "reports", ["asset_id"], name: "index_reports_on_asset_id", using: :btree
  add_index "reports", ["created_at"], name: "index_reports_on_created_at", using: :btree
  add_index "reports", ["room_id"], name: "index_reports_on_room_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string "name", limit: 32
  end

  add_index "rooms", ["name"], name: "index_rooms_on_name", unique: true, using: :btree

  add_foreign_key "assets", "asset_categories"
  add_foreign_key "assets", "rooms"
  add_foreign_key "reports", "asset_categories"
  add_foreign_key "reports", "assets"
  add_foreign_key "reports", "rooms"
end
