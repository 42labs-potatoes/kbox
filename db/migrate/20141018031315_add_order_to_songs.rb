class AddOrderToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :order, :integer
  end
end
