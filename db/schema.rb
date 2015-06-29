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

ActiveRecord::Schema.define(version: 20140930014903) do

  create_table "applications", force: true do |t|
    t.string   "name",          default: "", null: false
    t.string   "redirect_uri",               null: false
    t.string   "client_id"
    t.string   "client_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grants", force: true do |t|
    t.integer  "type",           default: 0, null: false
    t.integer  "user_id"
    t.integer  "application_id"
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grants", ["user_id", "application_id"], name: "index_grants_on_user_id_and_application_id", using: :btree

  create_table "moneta", id: false, force: true do |t|
    t.string "k", null: false
    t.binary "v"
  end

  add_index "moneta", ["k"], name: "index_moneta_on_k", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",         default: "", null: false
    t.string   "token"
    t.datetime "token_used_at"
    t.integer  "sign_in_count", default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
