class Inventory < ApplicationRecord
  validates :name, presence: true
  belongs_to :created_by, class_name: 'User'
end
