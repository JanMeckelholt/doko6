class AddPlayerToGamePlayer < ActiveRecord::Migration[6.0]
  def change
    add_reference :game_players, :player, foreign_key: true
  end
end
