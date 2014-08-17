class BuildingSerializer < ActiveModel::Serializer
  attributes :name, :lat, :lng
#  has_many :workspaces
end
