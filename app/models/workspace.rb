class Workspace < ActiveRecord::Base
  attr_accessible :building_id, :floor, :image_url, :location, :qty
  belongs_to :building
  has_and_belongs_to_many :equipments
  acts_as_mappable :default_units => :kms,
                   :default_formula => :flat,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
  has_many :change_requests
end
