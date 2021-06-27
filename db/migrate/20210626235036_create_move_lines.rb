class CreateMoveLines < ActiveRecord::Migration[6.0]
  def change
    create_table :move_lines do |t|
      t.integer :move_id, null: false
      t.integer :line_id, null: false

      t.timestamps
    end
    add_index :move_lines, :move_id
    add_index :move_lines, :line_id
    add_index :move_lines, [:move_id, :line_id], unique: true
  end
end
