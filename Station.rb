class Station
  def initialize name
    @name   = name

    @trains = []
  end

  def take_train train
    @trains << train
  end

  def kick_train train
    @trains.delete(train)
  end

  def display_trains type = nil
    # return all
    if type.nil?
      @trains

    # return by type
    else
      @trains.map do |train|
        train if train.tr_type == type.to_s
      end
    end
  end

  def trains_count type = nil
    # method return number of 'cargo' or 'pass' trains
    # if type is null, then will return count of all trains on the st

    if @trains.any?
      # return all
      if type.nil?
        @trains.size

      # return by type
      else
        @trains.map { |train| train if train.tr_type == type.to_s }.compact.size
      end
    end
  end

  def send_train tr_number = nil
    if @trains.any?
      if tr_number.nil?
        @trains.first.go_to_next_st
      else
        @trains.each do |train|
          if train.tr_number == tr_number.to_i
            train.go_to_next_st
            break
          end
        end
      end
    end
  end

  def name
    @name
  end
end

