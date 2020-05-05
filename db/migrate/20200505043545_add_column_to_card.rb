class AddColumnToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :played, :boolean, default: false
  end
end
