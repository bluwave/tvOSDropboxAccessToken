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

ActiveRecord::Schema.define(version: 20160101083745) do

  create_table "access", force: :cascade do |t|
    t.string   "tv_token"
    t.string   "dropbox_access_token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "user_id"
  end

  add_index "access", ["tv_token"], name: "index_Access_on_tv_token"

  create_table "accesses", force: :cascade do |t|
    t.string   "tv_token"
    t.string   "dropbox_access_token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "dropbox_accesses", force: :cascade do |t|
    t.string   "tv_token"
    t.string   "dropbox_access_token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
