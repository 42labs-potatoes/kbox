class Playlist < ActiveRecord::Base

  belongs_to :group
  has_many :songs
end
