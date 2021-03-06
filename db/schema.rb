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

ActiveRecord::Schema.define(version: 20140607223152) do

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "property_id"
  end

  create_table "properties", force: true do |t|
    t.integer  "user_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "radio_addr"
    t.string   "b_address1"
    t.string   "b_address2"
    t.string   "b_city"
    t.string   "b_state"
    t.string   "b_zipcode"
    t.string   "category"
    t.float    "bed"
    t.float    "bath"
    t.decimal  "price",          precision: 7, scale: 2
    t.boolean  "hasBrokerFee"
    t.boolean  "hasDeposit"
    t.decimal  "broker_fee",     precision: 7, scale: 2
    t.string   "deposit"
    t.text     "description"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.boolean  "archive"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_name"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "isPublic"
    t.string   "ip"
    t.boolean  "hasContract"
    t.string   "contract"
    t.integer  "gender"
    t.integer  "people"
    t.integer  "pet"
    t.integer  "count"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "hasInternet"
    t.boolean  "hasElectricity"
    t.boolean  "hasHeat"
  end

  create_table "searches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "admin",                  default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "about"
    t.date     "birthday"
    t.string   "education"
    t.integer  "gender"
    t.boolean  "verified"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "location"
    t.boolean  "can_post",               default: true
    t.string   "facebook_id"
    t.string   "weibo_id"
    t.string   "facebook_link"
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "fb_image"
    t.string   "confirmation_token"
    t.string   "language"
    t.string   "phone"
    t.string   "work"
    t.boolean  "is_public"
    t.string   "access_token"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
