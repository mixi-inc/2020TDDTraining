class CreatePhotobookPages < ActiveRecord::Migration[6.0]
  def change
    create_table :photobook_pages do |t|
      t.bigint :photobook_id, null: false
      t.integer :page_number, null: false
      t.bigint :media_id, null: false
      t.string :comment

      t.timestamps
    end
  end
end
