class WorkshopSerializer < ActiveModel::Serializer
  attributes :floor, :image_url, :location, :qty
  belongs_to :building
  has_many :equipments
end
