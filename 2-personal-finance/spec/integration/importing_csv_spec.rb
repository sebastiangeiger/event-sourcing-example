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
    before(:each) { account.import(file) }

    it "has the correct balance today" do
      balance = account.balance
      expect(balance).to be_within(0.01).of(-10122.05)
    end

    it "has the correct balance on August 2" do
      balance = account.balance(on: Date.parse("2014-08-02"));
      expect(balance).to be_within(0.01).of(-7911.20)
    end

    it "creates a snapshot every Sunday" do
      EventLog.process!
      sundays = (Date.parse("2014-03-01")..Date.today).select{|d| d.wday == 0}
      expect(AccountSnapshot.where(account: account).pluck(:date)).to eql sundays
    end
  end
end
