class InventorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  belongs_to :created_by
end
