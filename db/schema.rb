# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_08_225150) do

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "isbn"
    t.text "quote"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "note_type"
    t.text "body"
    t.integer "posting_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["posting_id"], name: "index_notes_on_posting_id"
  end

  create_table "postings", force: :cascade do |t|
    t.text "quote"
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "started_on"
    t.datetime "finished_on"
    t.integer "rating"
    t.text "note"
    t.integer "shelf_id"
    t.index ["book_id"], name: "index_postings_on_book_id"
    t.index ["shelf_id"], name: "index_postings_on_shelf_id"
    t.index ["user_id"], name: "index_postings_on_user_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_shelves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "token"
    t.string "secret"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "notes", "postings"
end
