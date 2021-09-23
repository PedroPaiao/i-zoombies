class CalculateDistances::Longitude < ::BaseService
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
    @current_longitude = survivor.location[:longitude]
  end

  def fetch_closest_west
    search_area = @current_longitude
    loop do
      @closer_weast_locations = Location.closest_west_long_area(@current_longitude, search_area, @location[:id])
      break unless @closer_weast_locations.blank?
      break if search_area > 180.0 || search_area < -180.0

      search_area += 10.0
    end
  end

  def fetch_closest_east
    search_area = @current_longitude
    loop do
      @closer_east_locations = Location.closest_east_long_area(@current_longitude, search_area, @location[:id])
      break unless @closer_east_locations.blank?
      break if search_area > 180.0 || search_area < -180.0

      search_area += 10.0
    end
  end

  def union_arrays
    @result_array = @closer_east_locations | @closer_weast_locations
  end

  def find_closest_location
    return if @result_array.blank?

    @result_array.each do |location|
      longitude = location[:longitude]

      distance = calculate_positive(longitude) if longitude.positive? && @current_longitude.positive?
      distance = calculate_opposite(longitude) if longitude.positive? && @current_longitude.negative?
      distance = calculate_negative(longitude) if longitude.negative? && @current_longitude.negative?
      distance = 0 if longitude.zero? && @current_longitude.zero?

      check_closest(distance, location)
    end
  end

  def check_closest(distance, location)
    if @result.nil?
      @result = { closest_array: [location], distance: distance.abs }
    elsif (@result[:distance]).abs > distance.abs
      @result[:closest_array] = [location]
      @result[:distance] = distance.abs
    elsif (@result[:distance]).abs == distance.abs
      @result[:closest_array] << location
    end
  end

  def calculate_positive(longitude)
    values = [@current_longitude, longitude]
    bigger_value = values.max
    small_value = values.min

    bigger_value - small_value
  end

  def calculate_opposite(longitude)
    values = [@current_longitude, longitude]
    bigger_value = values.max
    small_value = values.min

    bigger_value - (small_value * -1)
  end

  def calculate_negative(longitude)
    values = [@current_longitude, longitude]
    bigger_value = values.min
    small_value = values.max

    (bigger_value * -1) - (small_value * -1)
  end
end