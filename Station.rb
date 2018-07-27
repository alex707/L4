class Station
  attr_accessor :name
  attr_reader :trains

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

  def trains type = nil
    # return all
    if type.nil?
      @trains

    # return by type
    else
      @trains.map do |train|
        train if train.type == type.to_s
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
        @trains.map { |train| train if train.type == type.to_s }.compact.size
      end
    end
  end

  def send_train number = nil
    if @trains.any?
      if number.nil?
        @trains.first.go_to_next_st
      else
        @trains.each do |train|
          if train.number == number.to_s
            train.go_to_next_st
            break
          end
        end
      end
    end
  end
end
