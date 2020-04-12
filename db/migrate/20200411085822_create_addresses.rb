class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.bigint :account_id, null: false
      t.string :name, null: false
      t.string :zipcode, null: false
      t.string :address, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
