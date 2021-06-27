class CreateLines < ActiveRecord::Migration[6.0]
  def change
    create_table :lines do |t|
      t.string :line, null: false

      t.timestamps
    end
    add_index :lines, :line, unique: true
  end
end
