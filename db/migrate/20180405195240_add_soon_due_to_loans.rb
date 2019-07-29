class AddSoonDueToLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :soon_due, :boolean
  end
end
