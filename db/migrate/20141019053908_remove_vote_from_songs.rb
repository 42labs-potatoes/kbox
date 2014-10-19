class RemoveVoteFromSongs < ActiveRecord::Migration
  def change
    rename_column :songs, :vote, :integer
  end
end
