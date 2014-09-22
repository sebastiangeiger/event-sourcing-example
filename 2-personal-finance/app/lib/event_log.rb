class EventLog

  def self.process!
    AccountEvent.order(:date).each do |event|
      event.process!
    end
  end
end
