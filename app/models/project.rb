class Project < ApplicationRecord
  has_many :songs, dependent: :destroy
  has_many :setlists, dependent: :destroy

  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
