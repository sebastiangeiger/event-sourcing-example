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

class Ship < Struct.new(:name)
  attr_reader :location
  def initialize(name)
    super(name)
    @location = :unknown
  end
  def handle_arrival(event)
    @location = event.port
  end
  def handle_departure(event)
    @location = :at_sea
  end
end

class Port < Struct.new(:city, :country)
end
