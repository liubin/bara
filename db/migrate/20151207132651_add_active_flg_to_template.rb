class AddActiveFlgToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :active_flg, :integer
  end
end
