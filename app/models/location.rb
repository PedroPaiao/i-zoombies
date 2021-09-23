class Location < ApplicationRecord
  belongs_to :survivor

  validates :latitude, :longitude, presence: true

  scope :closest_west_long_area, lambda { |long, area|
    search_area = (long - area)
    order(longitude: :asc).where('longitude < ? and longitude > ?', long, search_area)
  }

  scope :closest_east_long_area, lambda { |long, area|
    search_area = (long + area)
    order(longitude: :asc).where('longitude > ? and longitude < ?', long, search_area)
  }

  scope :closest_north_lat_area, lambda { |lat, area|
    search_area = (lat + area)
    order(latitude: :asc).where('latitude > ? and latitude < ?', lat, search_area)
  }

  scope :closest_south_lat_area, lambda { |lat, area|
    search_area = (lat - area)
    order(latitude: :asc).where('latitude < ? and latitude > ?', lat, search_area)
  }
end
