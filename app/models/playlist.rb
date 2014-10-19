class Playlist < ActiveRecord::Base

  belongs_to :group
  has_many :songs, -> { order('position ASC')}

  validates_presence_of :group_id

  def play_next_song
    song = songs.first
    if (song)
      song.votes.destroy_all
      binding.pry
      song.update_columns(position: last_position+1, times: song.times+1)
      binding.pry
      # reposition_by_votes
      normalize_song_positions
    end
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
    # self.songs.sort_by(&:vote_count).reverse
    sorted_songs = self.songs.sort do |a,b|
      [a.vote_count, b[:position]] <=> [b.vote_count, a[:position]]
    end
    sorted_songs.reverse
  end

  def normalize_song_positions
    sort_by_votes.each_with_index do |song, index|
      song.update_attribute(:position, index+1)
    end
    binding.pry
  end

end
