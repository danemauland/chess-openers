class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :comment, null: false
      t.integer :move_id, null: false

      t.timestamps
    end
    add_index :comments, :move_id
  end
end
