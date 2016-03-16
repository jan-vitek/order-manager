class ChangeTimeEntrySpentTimeDefaultValue < ActiveRecord::Migration
  def change
    change_column :time_entries, :spent_time, :float, :default => 0
  end
end
