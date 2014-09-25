class BalanceQuery
  def initialize(date: , account:)
    @date = date
    @account = account
  end

  def execute
    snapshot = combine(nearest_snapshot, events_since_snapshot)
    OpenStruct.new(balance: snapshot[:balance])
  end

  private

  def nearest_snapshot
    @nearest_snapshot ||= AccountSnapshot.nearest_snapshot(date: @date, account: @account)
  end

  def events_since_snapshot
    AccountEventLog.new(@account).events(between: @nearest_snapshot.date .. @date)
  end

  def combine(snapshot, additional_events)
    ProcessingContext.new(starting_snapshot: snapshot, events: additional_events).
      process.
      snapshots.
      last
  end

end
