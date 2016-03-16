class Order < ActiveRecord::Base
  has_many :time_entries
  after_create :create_data_dir

  def create_data_dir
    require 'fileutils'
    FileUtils.mkpath('public/data/'+self.id.to_s)
  end 

  def spent_time
    return "0h" if self.time_entries.count == 0
    entries = self.time_entries.map{|e| e.spent_time}
    entries.sum.to_s + "h"
  end
end
