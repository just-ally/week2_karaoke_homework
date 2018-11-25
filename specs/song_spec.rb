require('minitest/autorun')
require('minitest/rg')
require_relative('../song.rb')

class SongTest < MiniTest::Test

  def setup
    @song1 = Song.new("Nightcall", "Kavinsky", 2010, "electronica")
    @song2 = Song.new("Cool to be you", "Descendents", 2004, "punk")

    @songs = [@song1, @song2]
  end

  def test_song_has_title()
    assert_equal("Nightcall", @song1.title)
  end

  def test_song_has_artist()
    assert_equal("Descendents", @song2.artist)
  end

  def test_song_release_year()
    assert_equal(2010, @song1.release_year)
  end

  def test_song_has_genre()
    assert_equal("punk", @song2.genre)
  end

end
