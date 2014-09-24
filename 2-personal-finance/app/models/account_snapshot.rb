class AccountSnapshot < ActiveRecord::Base
  attr_accessor :temp_balance
  belongs_to :account
  belongs_to :predecessor

  after_initialize do
    @temp_balance ||= balance
  end

  def self.nearest_snapshot(date:, account:)
    AccountSnapshot.where(['date < ? and account_id = ?', date, account.id]).order('date DESC').first ||
      InitialAccountSnapshot.new(account)
  end
end

class InitialAccountSnapshot < Struct.new(:account)
  attr_accessor :temp_balance
  attr_reader :date

  def initialize(account)
    super(account)
    @date = account.import_date
    @balance = account.import_balance
    @temp_balance = 0
  end
end
