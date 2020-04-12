class CreateChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :children do |t|
      t.bigint :album_id, null: false
      t.string :name, null: false
      t.datetime :birthday, null: false
      t.integer :sex, null: false

      t.timestamps
    end
  end
end
