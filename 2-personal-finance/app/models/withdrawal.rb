class Withdrawal < AccountEvent

  def process!
    account.cached_balance -= amount
    account.save
  end
end
