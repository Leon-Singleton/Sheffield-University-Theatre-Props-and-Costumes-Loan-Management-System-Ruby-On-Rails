class CreateColours < ActiveRecord::Migration[5.1]
  def change
    create_table :colours do |t|
      t.string :name 
      t.timestamps
    end
  end
end
