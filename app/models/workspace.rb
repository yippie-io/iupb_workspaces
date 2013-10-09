class Workspace < ActiveRecord::Base
  attr_accessible :building_id, :floor, :image_url, :location, :qty
  belongs_to :building
  has_and_belongs_to_many :equipments
end
