class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, uniqueness: true

  has_many :members
  has_many :projects, through: :members
end
