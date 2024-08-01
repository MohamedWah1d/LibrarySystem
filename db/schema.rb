# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_28_121225) do
  create_table "book_categories", force: :cascade do |t|
    t.integer "Book_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Book_id"], name: "index_book_categories_on_Book_id"
    t.index ["category_id"], name: "index_book_categories_on_category_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.float "rating"
    t.integer "review_count"
    t.integer "shelf_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shelf_id"], name: "index_books_on_shelf_id"
  end

  create_table "borrow_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.datetime "borrow_date"
    t.datetime "return_date"
    t.datetime "intended_return_date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrow_requests_on_book_id"
    t.index ["user_id"], name: "index_borrow_requests_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shelves", force: :cascade do |t|
    t.string "name"
    t.integer "max_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "book_categories", "Books"
  add_foreign_key "book_categories", "categories"
  add_foreign_key "books", "shelves"
  add_foreign_key "borrow_requests", "books"
  add_foreign_key "borrow_requests", "users"
end
