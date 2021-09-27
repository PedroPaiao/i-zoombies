class CalculateDistances::Inline < ::BaseService
  include CalculateDistanceHelper

  MAX_LONGITUDE = 180.0
  PLUS_SEARCH_AREA_VALUE = 5.0

  needs :survivor

  steps :fetch_survivor,
        :fetch_closest_west,
        :fetch_closest_east,
        :union_arrays,
        :find_closest_location

  def call
    process_steps
    @result
  end

  private

  def fetch_survivor
    @location = survivor.location
    @current_location = survivor.location
    @result = { closest_array: [], distance: 0 }
  end

  def fetch_closest_west
    search_area = @current_location[:longitude]
    loop do
      @closer_weast_locations = Location.closest_west_long_area(
        @current_location[:longitude],
        search_area,
        @location[:id]
      )
      break unless @closer_weast_locations.blank?
      break if search_area > MAX_LONGITUDE

      search_area += PLUS_SEARCH_AREA_VALUE
    end
  end

  def fetch_closest_east
    search_area = @current_location[:longitude]
    loop do
      @closer_east_locations = Location.closest_east_long_area(
        @current_location[:longitude],
        search_area, @location[:id]
      )
      break unless @closer_east_locations.blank?
      break if search_area > MAX_LONGITUDE

      search_area += PLUS_SEARCH_AREA_VALUE
    end
  end

  def union_arrays
    @result_array = @closer_east_locations | @closer_weast_locations
  end

  def find_closest_location
    return if @result_array.blank?

    @result_array.each do |location|
      distance = inline_calculate(@current_location, location)
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