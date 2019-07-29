class AddColourToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :colour_id, :integer
  end
end
