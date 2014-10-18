class Group < ActiveRecord::Base

  has_many :playlists
  has_many :songs , through: :playlists

  validates :name, presence: true, uniqueness: true
end
