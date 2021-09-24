class CalculateDistances::Latitude < ::BaseService
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

      distance = calculate_positive(latitude) if latitude.positive? && @current_latitude.positive?
      distance = calculate_opposite(latitude) if latitude.positive? && @current_latitude.negative?
      distance = calculate_negative(latitude) if latitude.negative? && @current_latitude.negative?
      distance = 0 if latitude.zero? && @current_latitude.zero?
      distance = calculate_positive(latitude) if (latitude.zero? || @current_latitude.zero?) &&
                                                 (@current_latitude.positive? || latitude.positive?)
      distance = calculate_negative(latitude) if (latitude.zero? || @current_latitude.zero?) &&
                                                 (@current_latitude.negative? || latitude.negative?)

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

  def calculate_positive(latitude)
    values = [@current_latitude, latitude]
    bigger_value = values.max
    small_value = values.min

    bigger_value - small_value
  end

  def calculate_opposite(latitude)
    values = [@current_latitude, latitude]
    bigger_value = values.max
    small_value = values.min

    bigger_value - (small_value * -1)
  end

  def calculate_negative(latitude)
    values = [@current_latitude, latitude]
    bigger_value = values.min
    small_value = values.max

    (bigger_value * -1) - (small_value * -1)
  end
end