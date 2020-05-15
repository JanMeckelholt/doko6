class Hand < ApplicationRecord

  #include ActiveModel::Model
  #
  has_many :cards, -> { order(id: :asc) }  
  belongs_to :game_player, optional: true
  
  validates :cards, length:{maximum: 10}

  

  def not_played
    self.cards.where(played: false)
  end



  private




  

end
