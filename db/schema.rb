# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080627193107) do

  create_table "blogs", :force => true do |t|
    t.integer "user_id", :limit => 11
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.integer  "post_id",    :limit => 11
    t.text     "body"
    t.datetime "created_at"
  end

  create_table "faqs", :force => true do |t|
    t.integer "user_id",    :limit => 11, :null => false
    t.text    "bio"
    t.text    "skillz"
    t.text    "schools"
    t.text    "companies"
    t.text    "music"
    t.text    "movies"
    t.text    "television"
    t.text    "magazines"
    t.text    "books"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",     :limit => 11
    t.integer  "friend_id",   :limit => 11
    t.string   "status"
    t.datetime "created_at"
    t.datetime "accepted_at"
  end

  create_table "geo_data", :force => true do |t|
    t.string "zip_code"
    t.float  "latitude"
    t.float  "longitude"
    t.string "city"
    t.string "state"
    t.string "county"
    t.string "type"
  end

  add_index "geo_data", ["zip_code"], :name => "zip_code_optimization"

  create_table "posts", :force => true do |t|
    t.integer  "blog_id",    :limit => 11
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "specs", :force => true do |t|
    t.integer  "user_id",    :limit => 11,                 :null => false
    t.string   "first_name",               :default => ""
    t.string   "last_name",                :default => ""
    t.string   "gender",                   :default => ""
    t.date     "birthdate"
    t.string   "occupation",               :default => ""
    t.string   "city",                     :default => ""
    t.string   "state",                    :default => ""
    t.string   "zip_code",                 :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "screen_name"
    t.string   "email"
    t.string   "password",            :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authorization_token"
  end

end
