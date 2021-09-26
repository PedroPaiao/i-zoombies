class Location < ApplicationRecord
  include FetchNextMoveHelper
  belongs_to :survivor

  validates :longitude, presence: true
  validates :latitude, presence: true

  validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }

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

  def shift
    next_lat, next_lat_dir = next_latitude(latitude, lat_direction)
    next_long, next_long_dir = next_latitude(longitude, long_direction)
    update(
      latitude: next_lat,
      lat_direction: next_lat_dir,
      longitude: next_long,
      long_direction: next_long_dir
    )
  end
end
