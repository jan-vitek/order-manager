class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :customer
      t.datetime :received_at
      t.datetime :finished_at
      t.datetime :deadline_at
      t.boolean :invoiced
      t.string :state
      t.float :spent_time
      t.float :price
      t.text :comment
      t.text :description

      t.timestamps
    end
  end
end
