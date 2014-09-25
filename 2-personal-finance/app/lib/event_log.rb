class EventLog
  def self.process!
    new.process!
  end

  def process!
    process_account_events!
  end

  private
  def process_account_events!
    Account.all.each do |account|
      AccountEventLog.new(account).process!
    end
  end
end
