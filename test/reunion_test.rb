require 'minitest'
require 'minitest/test'
require 'minitest/autorun'
require './lib/reunion'

class ReunionTest < Minitest::Test

  def test_it_exists
    r = Reunion.new("Downtown")

    assert_instance_of Reunion, r
    assert_equal "Downtown", r.location
  end

  def test_reunion_has_activities_array_created_empty
    r = Reunion.new("Downtown")

    assert_instance_of Array, r.activities
    assert_empty r.activities
  end

  def test_activities_can_be_added_to_reunion
    r = Reunion.new("Downtown")
    a = Activity.new("Hiking")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    r.add_activity(a)

    assert_equal 1, r.activities.count
    assert_equal 2, r.activities.first.participants.count
    assert_equal "Hiking", r.activities.first.name
    assert_equal ({"Gary"=>2.5, "Larry"=>-2.5}), r.activities.first.each_owes
  end

  def test_multiple_activities_can_be_added
    r = Reunion.new("Downtown")
    a = Activity.new("Hiking")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    r.add_activity(a)

    assert_equal 1, r.activities.count
    assert_equal 2, r.activities.first.participants.count
    assert_equal "Hiking", r.activities.first.name

    a2 = Activity.new("Karaoke")

    a2.add_participant("Mary", 15)
    a2.add_participant("Terry", 20)
    a2.add_participant("Kerry", 20)

    r.add_activity(a2)

    assert_equal 2, r.activities.count
    assert_equal 2, r.activities.first.participants.count
    assert_equal "Hiking", r.activities.first.name
    assert_equal 3, r.activities.last.participants.count
    assert_equal "Karaoke", r.activities.last.name
  end

  def test_total_reunion_cost_can_be_found
    r = Reunion.new("Downtown")
    a = Activity.new("Hiking")
    a2 = Activity.new("Karaoke")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    r.add_activity(a)

    assert_equal 25, r.total_cost

    a2.add_participant("Mary", 15)
    a2.add_participant("Terry", 20)
    a2.add_participant("Kerry", 20)

    r.add_activity(a2)

    assert_equal 80, r.total_cost
  end

  def test_total_number_of_reunion_activity_participants_can_be_found
    r = Reunion.new("Downtown")
    a = Activity.new("Hiking")
    a2 = Activity.new("Karaoke")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    r.add_activity(a)

    assert_equal 2, r.total_participants

    a2.add_participant("Mary", 15)
    a2.add_participant("Terry", 20)
    a2.add_participant("Kerry", 20)

    r.add_activity(a2)

    assert_equal 5, r.total_participants
  end

  def test_total_cost_can_be_even_split_amongst_participants
    r = Reunion.new("Downtown")
    a = Activity.new("Hiking")
    a2 = Activity.new("Karaoke")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    r.add_activity(a)

    assert_equal 12.5, r.split_cost

    a2.add_participant("Mary", 15)
    a2.add_participant("Terry", 20)
    a2.add_participant("Kerry", 20)

    r.add_activity(a2)

    assert_equal 16, r.split_cost
  end

  def test_test_cost_can_be_split_equally_and_show_owe_or_are_owed_for_each_participant
    r = Reunion.new("Downtown")
    a = Activity.new("Hiking")
    a2 = Activity.new("Karaoke")

    a.add_participant("Gary", 10)
    a.add_participant("Larry", 15)

    r.add_activity(a)

    assert_equal ({"Gary"=>2.5, "Larry"=>-2.5}), r.each_owes

    a2.add_participant("Mary", 15)
    a2.add_participant("Terry", 20)
    a2.add_participant("Kerry", 20)

    r.add_activity(a2)

    assert_equal ({"Gary"=>6.0, "Larry"=>1.0, "Mary"=>1.0, "Terry"=>-4.0, "Kerry"=>-4.0}), r.each_owes
  end
end
