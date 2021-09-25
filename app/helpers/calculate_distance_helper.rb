module CalculateDistanceHelper
  PI = 3.14
  EARTH_DAMN = 6371.0

  def one_way_calculate(current_location, way_value)
    return calculate_positive(current_location, way_value) if way_value.positive? && current_location.positive?
    return calculate_opposite(current_location, way_value) if way_value.positive? && current_location.negative?
    return calculate_negative(current_location, way_value) if way_value.negative? && current_location.negative?
    return 0 if way_value.zero? && current_location.zero?
    return calculate_positive(current_location, way_value) if (way_value.zero? || current_location.zero?) &&
                                                              (current_location.positive? || way_value.positive?)
    return calculate_negative(current_location, way_value) if (way_value.zero? || current_location.zero?) &&
                                                              (current_location.negative? || way_value.negative?)
  end

  def inline_calculate(current_location, way_location)
    lat1 = current_location[:latitude] * PI / 180.0
    long1 = current_location[:longitude] * PI / 180.0
    lat2 = way_location[:latitude] * PI / 180.0
    long2 = way_location[:longitude] * PI / 180.0

    lat = lat2 - lat1
    long = long2 - long1

    value = (Math.sin(lat / 2) * Math.sin(lat / 2)) +
            (Math.cos(lat1) * Math.cos(lat2) * Math.sin(long / 2) * Math.sin(long / 2))

    value = 2 * atan2(Math.sqrt(value), Math.sqrt(1 - value))

    EARTH_DAMN * value
  end

  private

  def calculate_positive(current_location, way_value)
    values = [current_location, way_value]
    values.max - values.min
  end

  def calculate_opposite(current_location, way_value)
    values = [current_location, way_value]
    values.max - (values.min * -1)
  end

  def calculate_negative(current_location, way_value)
    values = [current_location, way_value]
    (values.max * -1) - (values.min * -1)
  end

  def signal(float)
    float / float.abs
  end

  def atan2(y_value, x_value)
    if x_value.positive?
      Math.atan(y_value / x_value)
    elsif x_value.negative?
      Math.atan(y_value / x_value) + PI
    else
      PI / 2 * signal(y_value)
    end
  end
end