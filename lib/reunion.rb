require "./lib/activity"

class Reunion
  attr_reader :location,
              :activities

  def initialize(location)
    @location   = location
    @activities = Array.new
  end

  def add_activity(activity)
    activities << activity
  end

  def total_cost
    activities.map do |activity|
      activity.participants.values
    end.flatten.sum
  end

  def total_participants
    activities.map do |activity|
      activity.participants.keys
    end.flatten.count
  end

  def split_cost
    (total_cost.to_f / total_participants).round(2)
  end

  def each_owes
    people = activities.map { |activity| activity.participants.keys }
    amount_paid = activities.map { |activity| activity.participants.values }
    offset = amount_paid.flatten.map { |amount| split_cost - amount }
    people.flatten.zip(offset).to_h
  end
end
