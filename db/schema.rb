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

ActiveRecord::Schema.define(version: 20170330134347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credits", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "director_id"
    t.index ["director_id"], name: "index_credits_on_director_id", using: :btree
    t.index ["movie_id"], name: "index_credits_on_movie_id", using: :btree
  end

  create_table "directors", force: :cascade do |t|
    t.string "name", null: false
    t.string "imdb"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title",          null: false
    t.text   "description",    null: false
    t.string "original_title", null: false
  end

end
