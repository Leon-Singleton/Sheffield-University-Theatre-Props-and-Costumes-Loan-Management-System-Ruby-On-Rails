class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.datetime :date_from
      t.datetime :date_until
      t.boolean :returned
      t.boolean :request
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
