class DropNotifiedOfOverdueFromLoans < ActiveRecord::Migration[5.1]
  def change
    remove_column :loans, :notified_of_overdue
  end
end
