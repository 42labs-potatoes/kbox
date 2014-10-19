class Playlist < ActiveRecord::Base

  belongs_to :group
  has_many :songs, -> { order('position ASC')}

  validates_presence_of :group_id

  def play_next_song
    song = songs.first
    song.votes.destroy_all
    song.update_columns(position: last_position+1)
    # reposition_by_votes
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

  def sort_by_votes
    self.songs.sort_by(&:vote_count).reverse
  end

  def normalize_song_positions
    sort_by_votes.each_with_index do |song, index|
      song.update_attribute(:position, index+1)
    end
  end

end
