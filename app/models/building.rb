class Building < ActiveRecord::Base
  attr_accessible :lat, :long, :name, :url
  has_many :workspaces
end
