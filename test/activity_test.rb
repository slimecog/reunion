require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test

  def test_activity_has_a_name
    activity = Activity.new("Hiking")

    assert_equal "Hiking", activity.name
  end

  def test_activity_has_participants
    activity = Activity.new("Hiking")
    activity.add_participant("Gary", 10)

    assert_equal "Gary", activity.participants.first.key
    assert_equal 10, activity.participants.first.value
  end
  
  def test_total_cost_can_be_found
    activity = Activity.new("Hiking")
    activity.add_participant("Gary", 10)
    activity.add_participant("Susan", 10)

    assert_equal 20, activity.find_total_cost
  end

  def test_total_cost_can_be_split_equally
    activity = Activity.new("Hiking")
    activity.add_participant("Gary", 10)
    activity.add_participant("Susan", 10)

    assert_equal 10, activity.split_total_cost
  end
end
