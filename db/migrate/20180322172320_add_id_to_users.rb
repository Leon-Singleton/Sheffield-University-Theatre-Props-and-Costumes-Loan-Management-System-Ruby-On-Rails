class AddIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :loans, :user, index: true
  end
end
