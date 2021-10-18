# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable

  before_update :raise_role_change_error, if: :IT_admin? && :last_IT_admin?
  before_destroy :raise_role_delete_error, if: :IT_admin? && :last_IT_admin?

  enum role: {
    'inventory_manager': 0,
    'quality_check_person': 1,
    'sales_manager': 2,
    'IT_admin': 3
  }

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (reset_password_sent_at + 24.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

  def last_IT_admin?
    User.IT_admin.where.not(id: id).empty?
  end

  def raise_role_change_error
    self.errors.add(:role, "can't be updated for only IT employee")
    throw(:abort)
  end

  def raise_role_delete_error
    self.errors.add(:base, "Only IT employee can't be deleted")
    throw(:abort)
  end
end
