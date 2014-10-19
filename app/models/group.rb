class Group < ActiveRecord::Base

  has_one :playlist
  has_many :songs , through: :playlists

  validates :name, presence: true, uniqueness: true


  def current_listening_to
    cuurent_song.name if current_song
  end

  def current_song
    playlist.songs.find_by(position: 1)
  end
end