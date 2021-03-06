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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130210111525) do

  create_table "bookings", :force => true do |t|
    t.date     "from"
    t.date     "until"
    t.integer  "room_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "poi_id"
    t.integer  "interest_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "guests", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.date     "birthday"
    t.string   "current_city"
    t.integer  "tracker_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "importances", :force => true do |t|
    t.integer  "guest_id"
    t.integer  "interest_id"
    t.integer  "importance"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pois", :force => true do |t|
    t.string   "address"
    t.decimal  "long",        :precision => 10, :scale => 6
    t.decimal  "lat",         :precision => 10, :scale => 6
    t.integer  "duration"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "description"
    t.string   "name"
  end

  create_table "routes", :force => true do |t|
    t.string   "route"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
