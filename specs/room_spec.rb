require('minitest/autorun')
require('minitest/rg')
require_relative('../room.rb')
require_relative('../song.rb')
require_relative('../guest.rb')

class RoomTest < MiniTest::Test

  def setup
    song1 = Song.new("Nightcall", "Kavinsky", 2010, "electronica")
    song2 = Song.new("Cool to be you", "Descendents", 2004, "punk")

    songs = [song1, song2]

    @room = Room.new("Room 1", 3, 4.0, songs)

    @guest1 = Guest.new("Keith", 10.0, "Desecendents", "Cool to be you", "punk")
    @guest2 = Guest.new("Ally", 15.5, "Tycho", "Dive", "electronica")
    @guest3 = Guest.new("Jen", 12.0, "The Cure", "Pictures of you", "rock")
    @guest4 = Guest.new("Deb", 20.0, "Lauryn Hill", "Doo-wop", "hip-hop")

  end

  def test_room_has_name()
    assert_equal("Room 1", @room.name)
  end

  def test_room_has_capacity()
    assert_equal(3, @room.capacity)
  end

  def test_room_has_cost_to_enter
    assert_equal(4.0, @room.cost)
  end

  def test_room_has_playlist
    result = @room.check_playlist
    assert_equal(2, result.length)
  end

  def test_number_of_guests_in_room()
    assert_equal(0, @room.check_number_of_guests)
  end

  def test_number_of_guests_waiting()
    assert_equal(0, @room.check_guests_waiting)
  end

  def test_amount_in_till()
    assert_equal(0, @room.till)
  end

  def test_room_capacity__true_if_space()
    @room.guests << @guest1
    @room.guests << @guest2
    # not sure if I should use the add_guest function here - ask on Monday
    result = @room.check_capacity()
    assert_equal(true, result)
  end

  def test_room_capacity__false_if_no_space()
    @room.guests << @guest1
    @room.guests << @guest2
    @room.guests << @guest3
    # same query as test above
    result = @room.check_capacity()
    assert_equal(false, result)
  end

  def test_can_add_guest_to_room__space_available()
    @room.add_guest(@guest1)
    assert_equal(1, @room.check_number_of_guests)
    assert_equal(4.0, @room.till)
  end

  def test_add_guest_to_room__no_space()
    @room.add_guest(@guest1)
    @room.add_guest(@guest2)
    @room.add_guest(@guest3)
    @room.add_guest(@guest4)
    assert_equal(3, @room.check_number_of_guests)
    assert_equal(1, @room.check_guests_waiting)
  end

  def test_remove_guest_from_room()
    @room.add_guest(@guest1)
    @room.add_guest(@guest2)
    @room.add_guest(@guest3)
    @room.remove_guest(@guest2)
    assert_equal(2, @room.check_number_of_guests)
  end

  def test_move_guest_from_waiting_list_to_room()
    #arrange
    @room.add_guest(@guest1)
    @room.add_guest(@guest2)
    @room.add_guest(@guest3)
    @room.add_guest(@guest4)
    @room.remove_guest(@guest2)
    #act
    @room.move_guest_from_waiting_list_to_room(@guest4)
    #assert
    assert_equal(3, @room.check_number_of_guests)
    assert_equal(0, @room.check_guests_waiting)
  end

  def test_till_increase_as_guests_enter()
    @room.add_guest(@guest1)
    @room.add_guest(@guest2)
    @room.add_guest(@guest3)
    assert_equal(12.0, @room.till)
  end

  def test_add_song_to_room()
    song3 = Song.new("Born to Die", "Lana del Rey", 2012, "pop")
    @room.add_song_to_room(song3)
    result = @room.check_playlist
    assert_equal(3, result.length)
  end

  def test_find_favourite_song_by_genre__song_found()
    found_song = @room.find_song_by_genre("punk")
    result = found_song.title
    assert_equal("Cool to be you", result)
  end

  def test_find_favourite_song_by_genre__song_not_found()
    result = @room.find_song_by_genre("country")
    assert_equal("Sorry, that genre is not available.", result)
  end

  def test_find_favourite_song__song_found()
    result = @room.find_favourite_song_of_guest(@guest1)
    assert_equal("Whoo!", result)
  end

  def test_find_favourite_song__song_not_found()
    result = @room.find_favourite_song_of_guest(@guest2)
    assert_equal("Gutted!", result)
  end

  def test_find_related_by_genre__related_song_found()
    result = @room.find_a_related_song_by_genre(@guest2)
    assert_equal("You like electronica? Try this - Nightcall by Kavinsky!", result)
  end

  def test_find_related_by_genre__related_song_not_found()
    result = @room.find_a_related_song_by_genre(@guest3)
    assert_equal("We don't have any rock songs available - sorry!", result)
  end

end
