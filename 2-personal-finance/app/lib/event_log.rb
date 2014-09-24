class EventLog

  def initialize(snapshot: nil, events: nil)
    @events = events || AccountEvent.order('date ASC')
    @snapshot = snapshot || default_snapshot
  end

  def default_snapshot
    AccountSnapshot.create(account: Account.first,
                           balance: 0,
                           date: @events.first.date - 1.day)
  end

  def process
    @events.each do |event|
      event.process!(@snapshot)
    end
    @snapshot
  end

  def self.process!
    new.process
  end
end
