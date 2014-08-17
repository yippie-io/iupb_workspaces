class ChangeRequest < ActiveRecord::Base
  serialize :feedback, Hash
  attr_accessible :message, :lat, :lng, :workspace_id
  belongs_to :workspace

  def message=(msg)
    unless msg.nil?
      self.feedback = Hash.new if self.feedback.nil?
      self.feedback[:message] = msg
    end
  end

  def message
    self.feedback[:message] unless self.feedback.nil?
  end
end
