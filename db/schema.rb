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

ActiveRecord::Schema.define(version: 2021_06_26_235036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "comment", null: false
    t.integer "move_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["move_id"], name: "index_comments_on_move_id"
  end

  create_table "fens", force: :cascade do |t|
    t.string "fen", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fen"], name: "index_fens_on_fen", unique: true
  end

  create_table "lines", force: :cascade do |t|
    t.string "line", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["line"], name: "index_lines_on_line", unique: true
  end

  create_table "move_lines", force: :cascade do |t|
    t.integer "move_id", null: false
    t.integer "line_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["line_id"], name: "index_move_lines_on_line_id"
    t.index ["move_id", "line_id"], name: "index_move_lines_on_move_id_and_line_id", unique: true
    t.index ["move_id"], name: "index_move_lines_on_move_id"
  end

  create_table "move_tags", force: :cascade do |t|
    t.integer "move_id", null: false
    t.integer "tag_id", null: false
    t.index ["move_id", "tag_id"], name: "index_move_tags_on_move_id_and_tag_id", unique: true
    t.index ["move_id"], name: "index_move_tags_on_move_id"
    t.index ["tag_id"], name: "index_move_tags_on_tag_id"
  end

  create_table "moves", force: :cascade do |t|
    t.string "move", null: false
    t.integer "prev_fen_id", null: false
    t.integer "next_fen_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prev_fen_id", "move"], name: "index_moves_on_prev_fen_id_and_move", unique: true
    t.index ["prev_fen_id"], name: "index_moves_on_prev_fen_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag", null: false
    t.index ["tag"], name: "index_tags_on_tag", unique: true
  end

end
