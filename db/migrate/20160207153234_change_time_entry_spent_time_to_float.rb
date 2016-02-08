class ChangeTimeEntrySpentTimeToFloat < ActiveRecord::Migration
  def change
    change_column :time_entries, :spent_time, :float
  end
end
