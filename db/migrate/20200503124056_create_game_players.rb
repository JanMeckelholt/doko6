class CreateGamePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :game_players do |t|


      t.timestamps
    end
  end
end
