class Withdrawal < AccountEvent

  def process(snapshot)
    snapshot = snapshot.dup
    snapshot[:date] = date
    snapshot[:balance] -= amount
    snapshot
  end
end
