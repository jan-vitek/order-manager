class AddOrderIdToTimeEntry < ActiveRecord::Migration
  def change
    add_column :time_entries, :order_id, :integer
  end
end
