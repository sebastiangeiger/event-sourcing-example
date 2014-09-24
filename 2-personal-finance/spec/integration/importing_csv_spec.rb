require 'rails_helper'

RSpec.describe "Importing CSV Files" do
  let(:account) { Account.create(number: "123456",
                                 institution: "Wells Fargo",
                                 import_date: Date.parse("2014-03-01"),
                                 import_balance: 0) }
  it "has the correct balance" do
    expect(account.balance).to be_within(0.001).of(0)
  end
  context "when importing bank.csv" do
    let(:file) { File.absolute_path("bank.csv") }
    it "has the correct balance" do
      account.import(file)
      EventLog.process!
      expect(account.balance).to be_within(0.01).of(-10122.05)
    end
    it "has the correct balance" do
      account.import(file)
      EventLog.process!
      amount = account.balance(on: Date.parse("2014-08-01"));
      expect(amount).to be_within(0.01).of(-16682.89)
    end
  end
end
