class Song < ApplicationRecord
  has_and_belongs_to_many :setlists
  belongs_to :project
end
