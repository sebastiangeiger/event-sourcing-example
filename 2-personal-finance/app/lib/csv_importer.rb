require 'csv'
require 'pry'

class CsvImporter
  def initialize(file:,account:)
    @file = file
    @account = account
  end
  def import!
    CSV.table(@file, headers: true, header_converters: :symbol).each do |row|
      amount = row[:amount]
      type = amount < 0 ? "Withdrawal" : "CreditNote"
      amount = amount.abs
      AccountEvent.create(date: row[:date],
                          sender_receiver: row[:sender__receiver],
                          description: row[:description],
                          amount: amount,
                          account: @account,
                          type: type)
    end
  end
end
