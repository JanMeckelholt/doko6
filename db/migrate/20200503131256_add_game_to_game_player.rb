class AddGameToGamePlayer < ActiveRecord::Migration[6.0]
  def change

    remove_column :game_players, :player
    add_reference :game_players, :game, foreign_key: true
  end
end
