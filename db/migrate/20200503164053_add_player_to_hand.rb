class AddPlayerToHand < ActiveRecord::Migration[6.0]
  def change
    add_reference :hands, :player, foreign_key: true
  end
end
