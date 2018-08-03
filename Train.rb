class Train
  attr_reader :route, :speed, :number, :type

  def initialize(number, type)
    @number     = number
    @type       = type

    @speed      = 0

    @st_number  = nil
    @route      = nil
    @cars       = []
  end

  def accelerate
    @speed += 5
  end

  def breake
    @speed = 0
  end

  def route=(route)
    @route = route

    @st_number = 0
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

  def cars_count
    @cars.size
  end

  def car_disconnect
    @cars.delete_at(-1)
  end 

end

