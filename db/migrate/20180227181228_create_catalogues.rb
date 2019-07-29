class CreateCatalogues < ActiveRecord::Migration[5.1]
  def change
    create_table :catalogues do |t|
      t.string :name

      t.timestamps
    end
  end
end
