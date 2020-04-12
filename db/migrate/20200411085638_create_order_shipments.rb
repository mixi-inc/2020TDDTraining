class CreateOrderShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :order_shipments do |t|
      t.bigint :order_id, null: false
      t.bigint :address_id, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
