class WorkspaceSerializer < ActiveModel::Serializer
  attributes :floor, :image_url, :location, :qty, :lat, :lng, :id
  has_one :building
  has_many :equipments
end
