class CreateVisibilities < ActiveRecord::Migration[6.0]
  def change
    create_table :visibilities do |t|
      t.bigint :album_id, null: false

      t.timestamps
    end
  end
end
