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

ActiveRecord::Schema.define(version: 2022_02_07_043108) do

  create_table "authors", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "book_authors", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "books", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.integer "nopage"
    t.integer "quantity"
    t.decimal "price", precision: 10
    t.bigint "publisher_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

  create_table "categories", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "oder_details", charset: "utf8mb3", force: :cascade do |t|
    t.integer "quantity"
    t.string "deli_receiver"
    t.string "deli_address"
    t.string "deli_phone"
    t.decimal "total_price", precision: 10
    t.bigint "order_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_oder_details_on_book_id"
    t.index ["order_id"], name: "index_oder_details_on_order_id"
  end

  create_table "orders", charset: "utf8mb3", force: :cascade do |t|
    t.integer "status", limit: 1
    t.datetime "shiped_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "publishers", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.text "website"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.integer "phone"
    t.string "password_digest"
    t.string "activation_digest"
    t.integer "activated"
    t.string "reset_digest"
    t.string "remember_digest"
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.integer "role", limit: 1, default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "publishers"
  add_foreign_key "oder_details", "books"
  add_foreign_key "oder_details", "orders"
  add_foreign_key "orders", "users"
end
