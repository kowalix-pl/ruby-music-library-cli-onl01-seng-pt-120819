class Song 
  attr_accessor :artist, :name
  
  @@all = []
  
  def initialize (name, artist = nil, genre = nil)
   @name = name
   self.artist = artist if artist
   self.genre = genre if genre
  # @genre
  end 
  
  def self.all
    @@all
  end
  
  def self.destroy_all 
    @@all.clear
  end 
  
  def save
    @@all << self
  end 
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end 
  
  def genre
    @genre
  end 
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
  end
  
  def self.find_by_name(name)
    @@all.find{|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
      find_by_name(name) || create(name)
  end
  
  def self.new_from_filename(filename)
    song = self.new
    song.name= filename.split(" - ")[1]
    song
  end

end