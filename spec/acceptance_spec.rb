require 'rspec'
require 'pry'
require_relative "../lib/application"

describe 'Updating the application model' do

  let(:sf) { Port.new(city: "San Francisco", country: :USA) }
  let(:la) { Port.new(city: "Los Angeles", country: :USA) }
  let(:yyv) { Port.new(city: "Vancouver", country: :Canada) }
  let(:ship) { Ship.new("King Roy") }
  let(:refactoring_books) { Cargo.new("Refactoring") }
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

  describe 'keeping track of Canada' do
    it 'records that it has not been to canda' do
      events = [
        LoadEvent.new(     date: Time.new(2005,11,01), ship: ship, cargo: refactoring_books),
        DepartureEvent.new(date: Time.new(2005,11,02), ship: ship, port: la),
        ArrivalEvent.new(  date: Time.new(2005,11,24), ship: ship, port: sf),
        UnloadEvent.new(   date: Time.new(2005,11,25), ship: ship, cargo: refactoring_books)
      ]
      event_processor.process(events)
      expect(refactoring_books).to_not have_been_in_canada
    end
    it 'records that it passed through Canada' do
      events = [
        LoadEvent.new(     date: Time.new(2005,11,01), ship: ship, cargo: refactoring_books),
        DepartureEvent.new(date: Time.new(2005,11,02), ship: ship, port: la),
        ArrivalEvent.new(  date: Time.new(2005,11,13), ship: ship, port: yyv),
        DepartureEvent.new(date: Time.new(2005,11,14), ship: ship, port: yyv),
        ArrivalEvent.new(  date: Time.new(2005,11,24), ship: ship, port: sf),
        UnloadEvent.new(   date: Time.new(2005,11,25), ship: ship, cargo: refactoring_books)
      ]
      event_processor.process(events)
      expect(refactoring_books).to have_been_in_canada
    end
  end
end
