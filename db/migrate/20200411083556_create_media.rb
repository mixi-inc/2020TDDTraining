class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.bigint :album_id, null: false
      t.bigint :visibility_id, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
