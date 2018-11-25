class Guest

  attr_reader :name, :wallet, :favourite_artist, :favourite_song, :favourite_genre

  def initialize(name, wallet, favourite_artist, favourite_song, favourite_genre)
    @name = name
    @wallet = wallet
    @favourite_artist = favourite_artist
    @favourite_song = favourite_song
    @favourite_genre = favourite_genre
  end

  def sufficient_funds?(cost)
    return wallet >= cost
  end

  def pay_entrance_fee(cost)
    @wallet -= cost
  end

end
