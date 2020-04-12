class CreatePhotobooks < ActiveRecord::Migration[6.0]
  def change
    create_table :photobooks do |t|
      t.bigint :account_id, null: false
      t.bigint :album_id, null: false
      t.bigint :cover_media_id, null: false
      t.datetime :cover_media_taken_at, null: false
      t.string :title, null: false
      t.string :subtitle, null: false

      t.timestamps
    end
  end
end
