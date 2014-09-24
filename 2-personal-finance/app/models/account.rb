class Account < ActiveRecord::Base
  has_many :account_events

  def import(file)
    CsvImporter.new(file: file, account: self).import!
    self
  end

  def balance(on: Date.today)
    BalanceQuery.new(date: on, account: self).execute.balance
  end
end
