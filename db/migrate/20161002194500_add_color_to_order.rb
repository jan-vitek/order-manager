class AddColorToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :color, :string
  end
end
