class AddPlayerToGame < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :player, foreign_key: true
  end
end
