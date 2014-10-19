class Vote < ActiveRecord::Base
  belongs_to :song
  validates_uniqueness_of :ip, scope: :song_id
end