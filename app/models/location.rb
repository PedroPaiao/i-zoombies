class Location < ApplicationRecord
  belongs_to :survivor

  validates :latitude, :longitude, presence: true

  scope :closest_west_long_area, lambda { |long, area, id_loc|
    search_area = (long - area)
    order(longitude: :asc).where('longitude <= ? and longitude > ? and id != ?', long, search_area, id_loc)
  }

  scope :closest_east_long_area, lambda { |long, area, id_loc|
    search_area = (long + area)
    order(longitude: :asc).where('longitude > ? and longitude < ? and id != ?', long, search_area, id_loc)
  }

  scope :closest_north_lat_area, lambda { |lat, area, id_loc|
    search_area = (lat + area)
    order(latitude: :asc).where('latitude > ? and latitude < ? and id != ?', lat, search_area, id_loc)
  }

  scope :closest_south_lat_area, lambda { |lat, area, id_loc|
    search_area = (lat - area)
    order(latitude: :asc).where('latitude <= ? and latitude > ? and id != ?', lat, search_area, id_loc)
  }
end
