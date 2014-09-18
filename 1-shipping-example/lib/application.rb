# 1. Events
class DomainEvent
  attr_reader :recorded, :occurred
  def initialize(occurred: Time.now)
    @occurred = occurred
    @recorded = Time.now
  end
end

class ShipMovementEvent< DomainEvent
  attr_reader :date, :port, :ship
  def initialize(date: Date.today, port:, ship: )
    super(occurred: date)
    @port = port
    @ship = ship
  end
end

class ArrivalEvent < ShipMovementEvent
  def process
    @ship.handle_arrival(self)
  end
end

class DepartureEvent < ShipMovementEvent
  def process
    @ship.handle_departure(self)
  end
end

class CargoEvent < DomainEvent
  attr_reader :date, :cargo, :ship
  def initialize(date: Date.today, cargo:, ship: )
    super(occurred: date)
    @cargo = cargo
    @ship = ship
  end
end

class LoadEvent < CargoEvent
  def process
    @ship.handle_load(self)
  end
end

class UnloadEvent < CargoEvent
  def process
    @ship.handle_unload(self)
  end
end

class EventProcessor
  def initialize
    @event_list = []
  end
  def process(events)
    events = Array(events)
    events.sort_by(&:occurred).each(&:process)
    @event_list += events
  end
end

# 2. Domain Models
class Ship < Struct.new(:name)
  attr_reader :location
  def initialize(name)
    super(name)
    @location = :unknown
    @cargo = Set.new
  end
  def handle_arrival(event)
    @location = event.port
    @cargo.each {|c| c.handle_arrival(event)}
  end
  def handle_departure(event)
    @location = :at_sea
    @cargo.each {|c| c.handle_departure(event)}
  end
  def handle_load(event)
    @cargo.add(event.cargo)
  end
  def handle_unload(event)
    @cargo.delete(event.cargo)
  end
end

class Port
  attr_reader :city, :country
  def initialize(city:, country: )
    @city = city
    @country = country
  end
end

class Cargo < Struct.new(:name)
  def initialize(name)
    super(name)
    @has_been_in_canada = false
  end
  def has_been_in_canada?
    @has_been_in_canada
  end
  def handle_arrival(event)
    @has_been_in_canada = true if event.port.country == :Canada
  end
  def handle_departure(event); end
end
