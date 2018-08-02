class PassengerTrain < Train
  def car_connect(car)
    @cars << car if car.is_a?(PassengerCar)
  end

  def car_disconnect
    @cars.delete_at(-1)
  end
end

