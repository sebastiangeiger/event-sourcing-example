class BalanceQuery
  def initialize(date: , account:)
    @date = date
    @account = account
  end

  def execute
    snapshot = combine(nearest_snapshot, events_since_snapshot)
    OpenStruct.new(balance: snapshot.temp_balance)
  end

  private

  def nearest_snapshot
    @nearest_snapshot ||= AccountSnapshot.
      where(['date < ? and account_id = ?', @date, @account.id]).
      order('date DESC').first || raise("No snapshot found")
  end

  def events_since_snapshot
    AccountEvent.
      where(['date > ? and date <= ? and account_id = ?', nearest_snapshot.date, @date, @account.id]).
      all
  end

  def combine(snapshot, additional_events)
    EventLog.new(snapshot: snapshot, events: additional_events).process
  end

end
