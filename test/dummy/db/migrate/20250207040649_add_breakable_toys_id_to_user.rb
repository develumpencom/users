class AddBreakableToysIdToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :breakable_toys_id, :integer
  end
end
