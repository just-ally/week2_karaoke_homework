class Room

  attr_reader :name, :capacity, :cost, :guests, :till

  def initialize(name, capacity, cost, playlist)
    @name = name
    @capacity = capacity
    @cost = cost
    @playlist = playlist
    @guests = []
    @waiting_list = []
    @till = 0
  end

  def check_playlist
    return @playlist
  end

  def check_number_of_guests()
    return @guests.length
  end

  def check_guests_waiting()
    return @waiting_list.length
  end

  def check_capacity()
    return @guests.length < capacity
  end

  def add_guest(guest)
    return if guest.sufficient_funds?(@cost) == false
    if check_capacity == true
      @guests << guest
      guest.pay_entrance_fee(@cost)
      @till += @cost
    else
      @waiting_list << guest
    end
  end

  def remove_guest(guest)
    @guests.delete(guest)
  end

  def move_guest_from_waiting_list_to_room(guest)
    if @guests.length < 3 && @waiting_list.length >= 1
      guest_to_move = @waiting_list.shift
      @guests << guest_to_move
    end
  end

  def add_song_to_room(song)
    @playlist << song
  end

  def find_song_by_genre(genre_to_find)
    found_by_genre = @playlist.find {|song| song.genre == genre_to_find}
    if found_by_genre != nil
      return found_by_genre
    else
      return "Sorry, that genre is not available."
    end
  end

  def find_favourite_song_of_guest(guest)
    song_found = @playlist.find {|song| song.title == guest.favourite_song}
    if song_found != nil
      return "Whoo!"
    else
      return "Gutted!"
    end
  end

  def find_a_related_song_by_genre(guest)
    for song in @playlist
      if song.genre == guest.favourite_genre
        return "You like #{guest.favourite_genre}? Try this - #{song.title} by #{song.artist}!"
      end
    end
    return "We don't have any #{guest.favourite_genre} songs available - sorry!"
  end

end
