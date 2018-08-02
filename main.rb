load './Station.rb'
load './Route.rb'
load './Train.rb'
load './PassengerTrain.rb'
load './CargoTrain.rb'
load './Car.rb'

choise = ''

menu_text = <<-'MENU_TEXT'
Choose action:
  1   - Create station
  2   - Create train
  3   - Create route
  4   - Add station to route
  5   - Remove station from route
  6   - Set route to train
  7   - Add cars to train
  8   - Remove cars from train
  9   - Move train forward
  10  - Move train backward
  11  - Display stations list
  12  - Display trains list
  13  - Display routes list
(Enter 'stop' for exit)
MENU_TEXT


stations  = []
trains    = []
routes    = []

while choise != 'stop' do
  puts menu_text
  print 'Your choise: '
  choise = gets.chomp
  puts


  case choise
  when 'stop'
    puts 'Exiting...'
    next

  when '1'
    puts 'Enter station name: '
    name = gets.chomp
    stations << Station.new(name)

  when '2'
    print 'Enter train number: '
    number  = gets.chomp.to_i
    print "Enter train type ('pass' or 'cargo'): "
    type  = gets.chomp

    case type
    when 'pass'
      trains << PassengerTrain.new(number, type)
    when 'cargo'
      trains << CargoTrain.new(number, type)
    else
      puts "Type must be 'pass' or 'cargo'. Please, repeat saving of the train."
    end

  when '3'
    print 'Enter begin station name (from existing stations): '
    name_1 = gets.chomp
    print 'Enter end station name (from existing stations): '
    name_2 = gets.chomp

    st_1 = stations.map { |st| st if st.name == name_1 }.compact.first
    st_2 = stations.map { |st| st if st.name == name_2 }.compact.first

    if st_1 && st_2 
      routes << Route.new(st_1, st_2)
      puts "Route created succesfull."
    else
      puts 'Bad station name. Check stations(see p. 11). Route was not created.'
    end

  when '4'
    print 'Enter begin station name (first station of route): '
    name_1 = gets.chomp
    print 'Enter end station name (last station of route): '
    name_2 = gets.chomp

    route = routes.map { |r| r if r.st_begin.name == name_1 && r.st_end.name == name_2 }.compact.first
    if route.nil?
      puts 'Route not found.'
    else
      print 'Enter station name to add (from existing): '
      name_3 = gets.chomp

      station = stations.map { |s| s if s.name == name_3 }.compact.first
      if station.nil?
        puts 'Station for add not found. check station list (see p. 11)'
      else
        route.add_station station
        puts 'Station was added to route'
      end
    end

  when '5'
    print 'Enter begin station name (first station of route): '
    name_1 = gets.chomp
    print 'Enter end station name (last station of route): '
    name_2 = gets.chomp

    route = routes.map { |r| r if r.st_begin.name == name_1 && r.st_end.name == name_2 }.compact.first
    if route.nil?
      puts 'Route not found.'
    else
      print 'Enter station name to remove (from existing in route list): '
      name_3 = gets.chomp

      station = route.intermediate.map { |s| s if s.name == name_3 }.compact.first
      if station.nil?
        puts 'Station for remove not found. check station list in route(see p. 13)'
      else
        route.delete_station(name_3)
        puts 'Station was removed from route'
      end
    end

  when '6'
    print 'Enter train number for setting route: '
    number = gets.to_i

    train = trains.map { |t| t if t.number == number }.compact.first
    if train.nil?
      puts 'Train not found.'
    else
      print 'Enter begin station name (first station of route): '
      name_1 = gets.chomp
      print 'Enter end station name (last station of route): '
      name_2 = gets.chomp

      route = routes.map { |r| r if r.st_begin.name == name_1 && r.st_end.name == name_2 }.compact.first
      if route.nil?
        puts 'Route not found.'
      else
        train.route = route
        puts 'Route entered.'
      end
    end

  when '7'
    print 'Enter train number to add cars: '
    number = gets.to_i

    train = trains.map { |t| t if t.number == number }.compact.first
    if train.nil?
      puts 'Train not found.'
    else
      train.type == 'pass' ? train.car_connect(PassengerCar.new) : train.car_connect(CargoCar.new)
      puts 'Car added.'
    end

  when '8'
    print 'Enter train number to remove cars: '
    number = gets.to_i

    train = trains.map { |t| t if t.number == number }.compact.first
    if train.nil?
      puts 'Train not found.'
    else
      if train.cars_count == 0
        puts 'Can not to remove cars: cars count is zero.'
      else
        train.car_disconnect
        puts 'Car removed.'
      end
    end

  when '9'
    print 'Enter train number to move next station: '
    number = gets.to_i

    train = trains.map { |t| t if t.number == number }.compact.first
    if train.nil?
      puts 'Train not found.'
    else
      if train.route.nil?
        puts 'Can not move train: set route.'
      else
        train.go_to_next_st
        puts 'Train moved.'
      end
    end

  when '10'
    print 'Enter train number to move next station: '
    number = gets.to_i

    train = trains.map { |t| t if t.number == number }.compact.first
    if train.nil?
      puts 'Train not found.'
    else
      if train.route.nil?
        puts 'Can not move train: set route.'
      else
        train.go_to_prev_st
        puts 'Train moved.'
      end
    end

  when '11'
    puts "Station name  trains"
    stations.each do |st|
      puts "  #{st.name.rjust(10, ' ')}  #{st.trains.map(&:number).join(', ')}"
    end

  when '12'
    puts "Number       Type     Cars  Route"
    trains.each do |t|
      rr = ''
      unless t.route.nil?
        rr = "#{t.route.st_begin.name}-#{t.route.st_end.name}"
      end
      puts "#{t.number.to_s.rjust(9, ' ')}" \
        "#{t.type.rjust(8, ' ')}" \
        "#{t.cars_count.to_s.rjust(9, ' ')}  " \
        "#{rr}"
    end

  when '13'
    puts "Route name            stations"
    routes.each do |r|
      puts "#{(r.st_begin.name+'-'+r.st_end.name).rjust(20, ' ')}  " \
        "#{r.intermediate.map(&:name).join(', ')}"
    end

  else

  end


  puts
end

