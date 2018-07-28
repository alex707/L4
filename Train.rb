class Train
  attr_accessor :number, :type
  attr_reader :route, :speed, :car_count
  attr_writer :st_number

  def initialize(number, type, car_count)
    @number     = number
    @type       = type
    @car_count  = car_count

    @speed      = 0

    @st_number  = nil
    @route      = nil
  end

  def accelerate
    @speed += 5
  end

  def breake
    @speed = 0
  end

  def car_connect
    @car_count += 1 if @speed.zero?
  end

  def car_disconnect
    @car_count -= 1 if @speed.zero? && @car_count.nonzero?
  end

  def route=(route)
    @route = route

    self.st_number = 0
    station.take_train self
  end

  def go_to_next_st
    if @st_number != @route.stations.size - 1
      station.kick_train self
      @st_number += 1
      station.take_train self
    end
  end

  def go_to_prev_st
    if @st_number != 0
      station.kick_train self
      @st_number -= 1
      station.take_train self
    end
  end

  def prev_st
    @route.stations[@st_number - 1]
  end

  def station
    @route.stations[@st_number]
  end

  def next_st
    @route.stations[@st_number + 1]
  end
end

