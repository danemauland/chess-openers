class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.string :move, null: false
      t.integer :prev_fen_id, null: false
      t.integer :next_fen_id, null: false

      t.timestamps
    end
    add_index :moves, [:prev_fen_id, :move], unique: true
    add_index :moves, :prev_fen_id
  end
end
