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

ActiveRecord::Schema.define(version: 20160306005440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string   "name"
    t.integer  "team_id"
    t.string   "slack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "channels", ["team_id"], name: "index_channels_on_team_id", using: :btree

  create_table "sentiments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "channel_id"
    t.string   "slack_id"
    t.decimal  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "timestamp"
  end

  add_index "sentiments", ["channel_id"], name: "index_sentiments_on_channel_id", using: :btree
  add_index "sentiments", ["team_id"], name: "index_sentiments_on_team_id", using: :btree
  add_index "sentiments", ["user_id"], name: "index_sentiments_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "slack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "u_id"
    t.integer  "team_id"
    t.string   "token"
    t.string   "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

  add_foreign_key "channels", "teams"
  add_foreign_key "sentiments", "channels"
  add_foreign_key "sentiments", "teams"
  add_foreign_key "sentiments", "users"
  add_foreign_key "users", "teams"
end
