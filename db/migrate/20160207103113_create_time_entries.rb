class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :user_id
      t.integer :spent_time
      t.text :note

      t.timestamps
    end
  end
end
