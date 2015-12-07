class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.string :image
      t.string :cid
      t.integer :user_id
      t.string :param
      t.string :json

      t.timestamps null: false
    end

    add_index :containers, :cid, unique: true
  end
end
