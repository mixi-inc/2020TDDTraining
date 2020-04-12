class CreateVisibilityUserRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :visibility_user_relations do |t|
      t.bigint :visibility_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
