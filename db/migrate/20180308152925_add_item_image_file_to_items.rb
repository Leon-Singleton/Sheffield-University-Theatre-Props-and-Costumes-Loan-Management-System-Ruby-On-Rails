class AddItemImageFileToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :item_image_file, :string
  end
end
