class DropSoonDueFromLoans < ActiveRecord::Migration[5.1]
  def change
    remove_column :loans, :soon_due 
  end
end
