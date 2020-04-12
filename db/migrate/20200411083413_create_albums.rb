class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|

      t.timestamps
    end
  end
end
