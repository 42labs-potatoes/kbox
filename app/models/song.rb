class Song < ActiveRecord::Base

  # YT_LINK_FORMAT = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&v\?]*).*/i
  default_scope { order('position ASC') }
  belongs_to :playlist
  has_many :votes

  validates_presence_of :playlist_id, :uid
  validate :uid, presence: true
  # validate :uid, length: { is: 11}
  before_create :get_additional_info
  before_save :ensure_position

  # def ensure_uid
  #   uid = link.match(YT_LINK_FORMAT)
  #   self.uid = uid[2] if uid && uid[2]
  #   get_additional_info
  # end

  def ensure_position
    unless self.position
      # all_song_positions = Playlist.find(playlist_id).songs.all.map(&:position)
      # self.position = all_song_positions.empty? ? 1 : all_song_positions.max + 1
      self.position = Playlist.find(playlist_id).last_position + 1
    end
  end

  def vote_count
    votes.count
  end

  def self.get_song_hash(playlist_id)
    result = []
    Playlist.find(playlist_id).songs.each do |song|
      song_hash = {uid: song.uid, id: song.id, name: song.name, vote: song.vote_count}
      result << song_hash
    end
    result
  end

  private

  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: ENV["YOUTUBE_DEVELOPER_KEY"])
      song = client.video_by(uid)
      self.name = song.title
      self.duration = parse_duration(song.duration)
    rescue
      self.name = ''
      self.duration = '00:00:00'
    end
  end

  def parse_duration(duration)
    hr = (duration / 3600).floor
    min = ((duration - (hr * 3600)) / 60).floor
    sec = (duration - (hr * 3600) - (min * 60)).floor

    hr = '0' + hr.to_s if hr.to_i < 10
    min = '0' + min.to_s if min.to_i < 10
    sec = '0' + sec.to_s if sec.to_i < 10

    hr.to_s + ':' + min.to_s + ':' + sec.to_s
  end
end
