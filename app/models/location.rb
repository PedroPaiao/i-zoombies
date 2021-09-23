class Location < ApplicationRecord
  belongs_to :survivor

  validates :latitude, :longitude, presence: true
end
