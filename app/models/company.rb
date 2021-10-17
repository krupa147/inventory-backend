class Company < ApplicationRecord
  validate :name, presence: true

  has_many :users, dependent: :destroy
end
