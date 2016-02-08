class Order < ActiveRecord::Base
  has_many :time_entries

  def spent_time
    entries = self.time_entries.map{|e| e.spent_time}
    entries.sum.to_s + "h"
  end
end
