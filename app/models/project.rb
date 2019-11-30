class Project < ApplicationRecord
  has_many :songs
  has_many :setlists

  has_many :members
  has_many :users, through: :members
end
