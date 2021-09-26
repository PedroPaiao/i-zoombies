class CalculateDistances::Latitude < ::BaseService
  include CalculateDistanceHelper

  MAX_LATITUDE = 90.0
  PLUS_SEARCH_AREA_VALUE = 10.0

  needs :survivor

  steps :fetch_survivor,
        :fetch_closest_north,
        :fetch_closest_south,
        :union_arrays,
        :find_closest_location

  def call
    process_steps
    @result
  end

  private

  def fetch_survivor
    @location = survivor.location
    @current_latitude = survivor.location[:latitude]
    @result = { closest_array: [], distance: 0 }
  end

  def fetch_closest_north
    search_area = @current_latitude
    loop do
      @closer_north_locations = Location.closest_north_lat_area(@current_latitude, search_area, @location[:id])
      break unless @closer_north_locations.blank?
      break if search_area > 180.0

      search_area += 10.0
    end
  end

  def fetch_closest_south
    search_area = @current_latitude
    loop do
      @closer_south_locations = Location.closest_south_lat_area(@current_latitude, search_area, @location[:id])
      break unless @closer_south_locations.blank?
      break if search_area > 180.0

      search_area += 10.0
    end
  end

  def union_arrays
    @result_array = @closer_south_locations | @closer_north_locations
  end

  def find_closest_location
    return if @result_array.blank?

    @result_array.each do |location|
      latitude = location[:latitude]
      distance = one_way_calculate(@current_latitude, latitude)
      check_closest(distance, location)
    end
  end

  def check_closest(distance, location)
    if @result[:closest_array].blank? || ((@result[:distance]).abs > distance.abs)
      @result[:closest_array] = [location]
      @result[:distance] = distance.abs
    elsif (@result[:distance]).abs == distance.abs
      @result[:closest_array] << location
    end
  end
end