class Route
  attr_accessor :st_begin, :st_end
  attr_reader :intermediate

  def initialize st_begin, st_end
    @st_begin  = st_begin
    @st_end    = st_end

    @intermediate   = []
  end

  def add_station station
    @intermediate << station
  end

  def delete_station st_name
    @intermediate.delete_if { |s| s.name == st_name }
  end

  def stations
    [@st_begin] + @intermediate + [@st_end]
  end
end
