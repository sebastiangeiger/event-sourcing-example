class AccountSnapshot < ActiveRecord::Base
  def self.nearest_snapshot(date:, account:)
    InitialAccountSnapshot.new(account)
  end
end

class InitialAccountSnapshot < Struct.new(:account)
  attr_accessor :temp_balance
  attr_accessor :date

  def initialize(account)
    super(account)
    @date = account.import_date
    @balance = account.import_balance
    @temp_balance = 0
  end
end
