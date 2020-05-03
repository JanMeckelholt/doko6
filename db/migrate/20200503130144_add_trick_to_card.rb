class AddTrickToCard < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :trick, foreign_key: true
  end
end
