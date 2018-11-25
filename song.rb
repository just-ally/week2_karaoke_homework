class Song

  attr_reader :title, :artist, :release_year, :genre

  def initialize(title, artist, release_year, genre)
    @title = title
    @artist = artist
    @release_year = release_year
    @genre = genre
  end

end
