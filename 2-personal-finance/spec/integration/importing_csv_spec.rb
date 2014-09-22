require 'rails_helper'

RSpec.describe "Importing CSV Files" do
  let(:account) { Account.create(number: "123456", institution: "Wells Fargo") }
  it "has the correct balance" do
    expect(account.balance).to be_within(0.001).of(0)
  end
  context "when importing bank.csv" do
    let(:file) { File.absolute_path("bank.csv") }
    it "has the correct balance" do
      expect(account.import(file).balance).to be_within(0.001).of(-10122.05)
    end
  end
end


