class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :round
      t.integer :next_player

      t.timestamps
    end
  end
end
