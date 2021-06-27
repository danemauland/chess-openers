class CreateFens < ActiveRecord::Migration[6.0]
  def change
    create_table :fens do |t|
      t.string :fen, index: {unique: true}, null: false

      t.timestamps
    end
  end
end
