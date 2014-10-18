class AddIsPlayingToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :is_playing, :boolean
  end
end
