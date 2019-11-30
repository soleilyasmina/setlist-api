class Setlist < ApplicationRecord
  has_and_belongs_to_many :songs
  belongs_to :project
end
