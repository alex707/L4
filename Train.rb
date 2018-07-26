class Train
  def initialize tr_number, tr_type, car_cnt
    @tr_number  = tr_number
    @tr_type    = tr_type
    @car_cnt    = car_cnt

    @speed      = 0

    @cur_st_num = nil
    @route      = nil
  end

  def accelerate
    @speed += 5
  end

  def ret_current_speed
    @speed
  end

  def breake
    @speed = 0
  end

  def car_cnt
    @car_cnt
  end

  def ret_current_speed
    @speed
  end

  def car_connect
    @car_cnt += 1 if @speed.zero?
  end

  def car_disconnect
    @car_cnt -= 1 if @speed.zero? && @car_cnt.nonzero?
  end

  def set_route route
    @route = route

    self.cur_st_num = 0
    cur_station.take_train self
  end

  def go_to_next_st
    if @cur_st_num != @route.station_list.size - 1
      cur_station.kick_train self
      @cur_st_num += 1
      cur_station.take_train self
    end   
  end

  def go_to_prev_st
    if @cur_st_num != 0
      cur_station.kick_train self
      @cur_st_num -= 1
      cur_station.take_train self
    end
  end

  def get_prev_st
    @route.station_list[@cur_st_num - 1]
  end

  def cur_station
    @route.station_list[@cur_st_num]
  end

  def cur_st_num= cur_st_num
    @cur_st_num = cur_st_num
  end

  def get_next_st
    @route.station_list[@cur_st_num + 1]
  end

  def tr_type
    @tr_type
  end

  def tr_number
    @tr_number
  end
end

