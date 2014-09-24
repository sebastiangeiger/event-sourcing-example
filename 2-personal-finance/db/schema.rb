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

ActiveRecord::Schema.define(version: 20140924133758) do

  create_table "account_events", force: true do |t|
    t.date     "date"
    t.string   "sender_receiver"
    t.string   "description"
    t.float    "amount"
    t.string   "type"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_snapshots", force: true do |t|
    t.integer  "account_id"
    t.float    "balance"
    t.date     "date"
    t.integer  "predecessor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_snapshots", ["account_id"], name: "index_account_snapshots_on_account_id"
  add_index "account_snapshots", ["predecessor_id"], name: "index_account_snapshots_on_predecessor_id"

  create_table "accounts", force: true do |t|
    t.string   "institution"
    t.string   "number"
    t.float    "cached_balance", default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
