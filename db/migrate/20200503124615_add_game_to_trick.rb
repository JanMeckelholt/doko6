class AddGameToTrick < ActiveRecord::Migration[6.0]
  def change
    add_reference :tricks, :game, foreign_key: true
  end
end
