class Withdrawal < AccountEvent

  def process!(snapshot)
    snapshot = snapshot.dup
    snapshot.date = date
    snapshot.temp_balance -= amount
    snapshot
  end
end
