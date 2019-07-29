class AddNotifiedOfOverdueToLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :notified_of_overdue, :boolean
  end
end
