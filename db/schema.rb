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

ActiveRecord::Schema.define(:version => 20131230070834) do

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
  end

  create_table "media_profiles", :force => true do |t|
    t.string   "media_type"
    t.string   "title"
    t.string   "name"
    t.string   "designation"
    t.string   "company_name"
    t.string   "office_phone"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
