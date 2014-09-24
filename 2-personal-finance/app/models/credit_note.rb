class CreditNote < AccountEvent

  def process!(snapshot = nil)
    if snapshot
      snapshot.temp_balance += amount
    else
      account.cached_balance += amount
      account.save # TODO: Need to remove that
    end
  end
end
