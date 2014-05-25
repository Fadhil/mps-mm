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

ActiveRecord::Schema.define(:version => 20140523191908) do

  create_table "addresses", :force => true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "postcode"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.integer  "city_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "attendance_lists", :force => true do |t|
    t.integer  "event_id"
    t.integer  "attendee_counter"
    t.boolean  "completed"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "attendees", :force => true do |t|
    t.integer  "media_profile_id"
    t.boolean  "attended"
    t.integer  "attendance_list_id"
    t.string   "attendance_status"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "name"
    t.string   "email"
    t.string   "company_name"
    t.string   "phone"
    t.string   "type"
    t.boolean  "rsvp"
    t.string   "media_type"
    t.boolean  "email_read"
    t.string   "invitation"
    t.string   "letter"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "state_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.date     "date"
    t.time     "time"
    t.string   "venue"
    t.string   "official"
    t.string   "organizer"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "letter"
    t.string   "agenda_details"
    t.string   "name"
    t.string   "invitation"
  end

  add_index "events", ["name"], :name => "index_events_on_name"

  create_table "media_profiles", :force => true do |t|
    t.string   "media_type"
    t.string   "title"
    t.string   "name"
    t.string   "designation"
    t.string   "company_name"
    t.string   "office_phone"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "personal_email"
    t.string   "media_name"
    t.boolean  "is_internal",    :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
