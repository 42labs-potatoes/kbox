class RenameOrderToPositionForSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :order
    add_column :songs, :position, :integer
  end
end
