class WorkspaceSerializer < ActiveModel::Serializer
  attributes :floor, :image_url, :location, :qty, :lat, :lng
  belongs_to :building
  has_many :equipments
end
