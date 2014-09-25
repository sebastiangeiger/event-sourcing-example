class AccountEventLog
  def initialize(account)
    @account = account
  end

  def events(between: nil)
    if between
      AccountEvent.
        where(['date > ? and date <= ? and account_id = ?', between.first, between.last, @account.id])
    else
      AccountEvent.where(account: @account)
    end
  end


  def process!
    snapshots = ProcessingContext.new(starting_snapshot: snapshot, events: events).
      process.
      snapshots
  end

  private
  def snapshot
    @account.initial_snapshot
  end

end
