class Activity
  attr_reader :name,
              :participants

  def initialize(name)
    @name         = name
    @participants = Hash.new
  end

  def add_participant(participant, amount_paid)
    participants[participant] = amount_paid
  end

  def total_cost
    participants.values.sum
  end

  def split_cost
    (total_cost.to_f / participants.count).round(2)
  end

  def each_owes
    people = participants.keys.map { |key| key }
    owes   = participants.values.map do |value|
      value = (split_cost - value).round(2)
    end
    people.zip(owes).to_h
  end
end
