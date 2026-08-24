class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :name, with: ->(name) { name.strip }

  validates :name, presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :age,
            numericality: { only_integer: true, greater_than: 0, message: "must be a positive integer" },
            allow_nil: true
end

