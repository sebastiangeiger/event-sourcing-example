class Account < ActiveRecord::Base
  has_many :account_events

  def import(file)
    CsvImporter.new(file: file, account: self).import!
    self
  end

  def balance
    EventLog.process!
    self.reload.cached_balance
  end
end
