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

ActiveRecord::Schema.define(:version => 20110329014140) do

  create_table "administrators", :force => true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funds", :force => true do |t|
    t.integer  "run"
    t.integer  "run_dv"
    t.string   "name"
    t.integer  "administrator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.integer  "specific_fund_id"
    t.date     "date"
    t.decimal  "quote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["date"], :name => "index_quotes_on_date"
  add_index "quotes", ["specific_fund_id"], :name => "index_quotes_on_specific_fund_id"

  create_table "series", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specific_funds", :force => true do |t|
    t.integer  "fund_id"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
