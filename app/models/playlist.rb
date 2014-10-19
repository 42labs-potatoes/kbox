class Playlist < ActiveRecord::Base

  belongs_to :group
  has_many :songs, -> { order('position ASC')}

  validates_presence_of :group_id

  def play_next_song
    songs.first.update_attribute(:position, last_position+1)
    normalize_song_positions
  end

  def last_position
    all_song_positions = self.songs.all.map(&:position)
    all_song_positions.empty? ? 0 : all_song_positions.max
  end

  def update_multiple_song_position(song_info_items)
    song_info_items.each do |song_info_item|
      song = Song.find(song_info_item[:song_id])
      song.update_attribute(:position, song_info_item[:position])
    end
  end

  private

  def normalize_song_positions
    songs.each_with_index do |song, index|
      song.update_attribute(:position, index+1)
    end
  end

end
