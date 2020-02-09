 require 'pry'
class Song 
  attr_accessor :name, :artist, :genre
   extend Concerns::Findable
  @@all = []
  
  def initialize (name, artist = nil, genre = nil)
   @name = name
   self.artist = artist if artist
   self.genre = genre if genre
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
  
  
   def self.new_from_filename(filename)
     new_arr = filename.split(" - ")
     artist = Artist.find_or_create_by_name(new_arr[0])
     song = new_arr[1]
     genre = Genre.find_or_create_by_name(new_arr[2].gsub(".mp3", ""))
     new_song = self.new(song, artist, genre)
     new_song
   end 
   
  def self.create_from_filename(filename)
    @@all<< self.new_from_filename(filename)
  end 
  
end