class User < ApplicationRecord

  devise :database_authenticatable

  belongs_to :company, optional: true

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
    (self.reset_password_sent_at + 24.hours) > Time.now.utc
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
end
