class AddPlayerToTrick < ActiveRecord::Migration[6.0]
  def change
    add_reference :tricks, :game_player, foreign_key: true
  end
end
