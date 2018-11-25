require('minitest/autorun')
require('minitest/rg')
require_relative('../guest.rb')
require_relative('../room.rb')

class GuestTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Keith", 10.0, "Descendents", "Cool to be you", "punk")

    @room = Room.new("Room 1", 3, 4.0, [])
  end

  def test_guest_has_name()
    assert_equal("Keith", @guest1.name)
  end

  def test_guest_wallet()
    assert_equal(10.0, @guest1.wallet)
  end

  def test_guest_has_favourite_artist()
    assert_equal("Descendents", @guest1.favourite_artist)
  end

  def test_guest_has_favourite_genre()
    assert_equal("punk", @guest1.favourite_genre)
  end

  def test_if_guest_has_sufficient_funds__true()
    result = @guest1.sufficient_funds?(@room.cost)
    assert_equal(true, result)
  end

  def test_if_guest_has_sufficient_funds__false()
    guest2 = Guest.new("Ally", 2.5, "Tycho", "Dive", "electronica")
    result = guest2.sufficient_funds?(@room.cost)
    assert_equal(false, result)
  end

  def test_guest_pay_fee()
    @guest1.pay_entrance_fee(@room.cost)
    assert_equal(6.0, @guest1.wallet)
  end


end
