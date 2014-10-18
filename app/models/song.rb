class Song < ActiveRecord::Base

  # YT_LINK_FORMAT = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&v\?]*).*/i
  belongs_to :playlist

  # validates_presence_of :name, :playlist_id
  validate :uid, presence: true
  # validate :uid, length: { is: 11}
  before_create :get_additional_info

  # def ensure_uid
  #   uid = link.match(YT_LINK_FORMAT)
  #   self.uid = uid[2] if uid && uid[2]
  #   get_additional_info
  # end

  private

  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: 'AIzaSyAfdk9o_YixCCW0SuKZO4DWcoARtXvnjps')
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
