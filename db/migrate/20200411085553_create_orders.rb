class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :account_id, null: false
      t.bigint :product_id, null: false
      t.bigint :content_id, null: false
      t.integer :price, null: false
      t.integer :shipping_cost, null: false

      t.timestamps
    end
  end
end
