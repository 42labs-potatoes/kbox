class AddLinkVoteTimesAndDurationToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :link, :string
    add_column :songs, :vote, :integer
    add_column :songs, :times, :integer
    add_column :songs, :duration, :string
  end
end
