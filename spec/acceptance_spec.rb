require 'rspec'
require 'pry'
require_relative "../lib/application"

describe 'Updating the application model' do

  let(:sf) { Port.new(city: "San Francisco", country: :USA) }
  let(:la) { Port.new(city: "Los Angeles", country: :USA) }
  let(:yyv) { Port.new(city: "Vancouver", country: :Canada) }
  let(:ship) { Ship.new("King Roy") }
  let(:cargo) { Cargo.new("Refactoring") }
  let(:event_processor) { EventProcessor.new }

  it 'sets the ships location on arrival' do
    event = ArrivalEvent.new(date: Time.new(2005,11,01), ship: ship, port: sf)
    event_processor.process(event)
    expect(ship.location).to eql sf
  end

  it 'puts the ship at sea when departing from a port' do
    events = [
      ArrivalEvent.new(  date: Time.new(2005,10,01), ship: ship, port: la),
      ArrivalEvent.new(  date: Time.new(2005,11,01), ship: ship, port: sf),
      DepartureEvent.new(date: Time.new(2005,11,01), ship: ship, port: sf)
    ]
    event_processor.process(events)
    expect(ship.location).to eql :at_sea
  end
end
