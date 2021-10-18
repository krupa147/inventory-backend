class User < ApplicationRecord

  devise :database_authenticatable

  belongs_to :company, optional: true

  enum role: {
    'inventory_manager': 0,
    'quality_check_person': 1,
    'sales_manager': 2,
    'IT_admin': 3
  }
end
