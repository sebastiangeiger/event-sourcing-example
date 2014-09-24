class AccountSnapshot < ActiveRecord::Base
  attr_accessor :temp_balance
  belongs_to :account
  belongs_to :predecessor

  after_initialize do
    @temp_balance ||= balance
  end
end
