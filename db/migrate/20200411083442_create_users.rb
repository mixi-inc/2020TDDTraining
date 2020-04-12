class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.bigint :account_id, null: false
      t.bigint :album_id, null: false
      t.string :nickname, null: false
      t.string :relationship, null: false

      t.timestamps
    end
  end
end
