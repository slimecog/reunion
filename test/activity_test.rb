require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test

  def test_activity_has_a_name
    a = Activity.new("Hiking")

    assert_instance_of Activity, a
    assert_equal "Hiking", a.name
  end

  def test_it_is_created_with_empty_participants_array
    a = Activity.new("Hiking")

    assert_instance_of Hash, a.participants
    assert_empty a.participants
  end

  def test_participants_can_be_added
    a = Activity.new("Hiking")

    a.add_participant("Gary", 10)

    assert_equal 1, a.participants.count
    assert_equal "Gary", a.participants.first.first
    assert_equal 10, a.participants.first.last

    a.add_participant("Larry", 15)

    assert_equal 2, a.participants.count
    assert_equal ["Gary", "Larry"], a.participants.keys
    assert_equal [10, 15], a.participants.values
  end

  def test_total_activity_cost_can_be_found
    a = Activity.new("Hiking")

    a.add_participant("Gary", 10)

    assert_equal 10, a.total_cost

    a.add_participant("Larry", 15)

    assert_equal 25, a.total_cost
  end

  def test_cost_can_be_split_equally_and_show_average_cost_to_the_penny
    a = Activity.new("Hiking")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    assert_equal 12.5, a.split_cost

    a.add_participant("Barry", 15)

    assert_equal 13.33, a.split_cost
  end

  def test_cost_can_be_split_equally_and_show_owe_or_are_owed_for_each_participant
    a = Activity.new("Hiking")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    assert_equal ({"Gary"=>2.5, "Larry"=>-2.5}), a.each_owes

    a.add_participant("Barry", 20)

    assert_equal ({"Gary"=>5.0, "Larry"=>0.0, "Barry"=>-5.0}), a.each_owes
  end
end
