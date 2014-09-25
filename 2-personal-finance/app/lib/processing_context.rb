class ProcessingContext
  attr_reader :snapshots

  def initialize(starting_snapshot:,events:)
    @events = events
    @snapshots = [starting_snapshot.to_hash]
  end

  def process
    @events.each do |event|
      @snapshots << event.process(@snapshots.last)
    end
    self
  end


end
