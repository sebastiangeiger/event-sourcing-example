class AccountSnapshot < ActiveRecord::Base
  belongs_to :account

  def self.nearest_snapshot(date:, account:)
    account.initial_snapshot
  end
end

class InitialAccountSnapshot < Struct.new(:account)
  attr_accessor :date

  def initialize(account)
    super(account)
    @date = account.import_date
    @balance = account.import_balance
  end

  def to_hash
    {
      date: @date,
      balance: @balance,
      account: account
    }
  end
end
