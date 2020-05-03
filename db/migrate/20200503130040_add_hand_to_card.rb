class AddHandToCard < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :hand, foreign_key: true
  end
end
