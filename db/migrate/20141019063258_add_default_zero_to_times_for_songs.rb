class AddDefaultZeroToTimesForSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :times
    add_column :songs, :times, :integer, default: 0
  end
end