class EventLog #TODO: Needs to have AccountEventLog

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
  end
  def self.process!
    new.process
  end
end
