class Distance

  def self.for(directions:, initial_orientation: :north)

    result = ParseDirections.from(directions: directions).reduce(initial_trip(initial_orientation)) do |trip, step|
      new_orientation = Direction.orient(bearing: trip[:orientation], turn: step[:turn])
      trip[new_orientation] += step[:distance]
      trip[:orientation] = new_orientation
      trip
    end

    (result[:north] - result[:south]).abs + (result[:east] - result[:west]).abs
  end

  def self.initial_trip(orientation)
    { orientation: orientation, north: 0, east: 0, south: 0, west: 0 }
  end
end

class ParseDirections

  TURN_DIRECTION = {
    "R" => :right,
    "L" => :left,
  }

  def self.from(directions:)
    new.parse(directions)
  end

  def parse(directions)
    steps = directions.split(", ")
    steps.map { |step| { distance: parse_distance(step), turn: parse_turn(step) } }
  end

  private

  def parse_distance(step)
    step.gsub(/\D/, "").to_i
  end

  def parse_turn(step)
    non_digit_characters = step.gsub(/\d/, "")

    TURN_DIRECTION[non_digit_characters]
  end
end

class Direction

  RELATIVE_DIRECTIONS = {
    north: { left: :west, right: :east },
    east: { left: :north, right: :south },
    south: { left: :east, right: :west },
    west: { left: :south, right: :north },
  }

  def self.orient(bearing:, turn:)
    RELATIVE_DIRECTIONS[bearing][turn]
  end
end
