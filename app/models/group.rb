class Group < ActiveRecord::Base

  has_one :playlist
  has_many :songs , through: :playlists

  validates :name, presence: true, uniqueness: true

end