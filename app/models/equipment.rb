class Equipment < ActiveRecord::Base
  attr_accessible :image_url, :name
  has_and_belongs_to_many :workspaces
end
