class AddActiveOrderToUser < ActiveRecord::Migration
  def change
    add_column :users, :active_order_id, :integer
  end
end
