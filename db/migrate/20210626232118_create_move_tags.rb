class CreateMoveTags < ActiveRecord::Migration[6.0]
  def change
    create_table :move_tags do |t|
      t.integer :move_id, null: false
      t.integer :tag_id, null: false
    end
    add_index :move_tags, :move_id
    add_index :move_tags, :tag_id
    add_index :move_tags, [:move_id, :tag_id], unique: true
  end
end
