class Building < ActiveRecord::Base
  attr_accessible :lat, :lng, :name, :url
  has_many :workspaces
end
