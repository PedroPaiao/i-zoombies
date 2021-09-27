module FetchNextMoveHelper
  MAX_LATITUDE = 90.0
  MAX_LONGTUDE = 180.0
  SPEED = 10.0

  def next_longitude(longitude, direction)
    next_move = calculate(longitude, direction)

    if next_move.abs > MAX_LONGTUDE
      direction = invert_direction(direction)
      next_move = calculate(longitude, direction)
    end

    [next_move, direction]
  end

  def next_latitude(latitude, direction)
    next_move = calculate(latitude, direction)

    if next_move.abs > MAX_LATITUDE
      direction = invert_direction(direction)
      next_move = calculate(latitude, direction)
    end

    [next_move, direction]
  end

  private

  def invert_direction(direction)
    direction * -direction
  end

  def calculate(value, direction)
    value.abs + (SPEED * direction)
  end
end