class AddHandToCard < ActiveRecord::Migration[6.0]
  def change
    add_reference :cards, :hand, foreign_key: true, on_delete: :cascade
  end
end
