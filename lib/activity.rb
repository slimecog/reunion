class Activity
  attr_reader :name,
              :participant,
              :amount_paid,
              :participants,
              :total_cost

  def initialize(name)
    @name         = name
    @participant  = participant
    @amount_paid  = amount_paid
    @participants = {}
    @total_cost   = total_cost
  end

  def add_participant({participant: amount_paid})
    if @participants.nil?
      @participants = {participant: amount_paid}
    else @participants.merge participants: amount_paid
    end
  end

  def find_total_cost
    @total_cost = participants.map {|cost| cost[participant]}.reduce(0, :+)
  end

  def split_total_cost
    @total_cost / (@participants.count)
  end
end
