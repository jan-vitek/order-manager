class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  def increase_time seconds
    self.update_attributes(spent_time: self[:spent_time] + seconds.to_f/3600)
  end

  def spent_time
    return 0 if self[:spent_time].nil?
    self[:spent_time].round(3)
  end
end
