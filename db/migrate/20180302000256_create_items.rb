class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :code
      t.text :description
      t.boolean :costume

      t.timestamps
    end
  end
end
