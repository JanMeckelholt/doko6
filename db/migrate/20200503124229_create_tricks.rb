class CreateTricks < ActiveRecord::Migration[6.0]
  def change
    create_table :tricks do |t|

      t.timestamps
    end
  end
end
