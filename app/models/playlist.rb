class Playlist < ActiveRecord::Base

  belongs_to :group
  has_many :songs

  validates_presence_of :group_id
end
