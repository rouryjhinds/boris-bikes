require_relative 'bike'

class DockingStation
  attr_reader :bikes

  def initialize
    @bikes = []
  end
  
  def release_bike
    fail 'No bikes, bro' if @bikes.empty?
    @bikes.pop
  end

  def dock(bike)
    fail 'This dock be full, bro' if @bikes.count >= 20
    @bikes << bike
  end
end