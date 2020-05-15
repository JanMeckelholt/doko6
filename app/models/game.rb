class Game < ApplicationRecord
  before_destroy :clear_tricks
  #include ActiveModel::Model
  has_one :deck, dependent: :destroy 

  #belongs_to :player
  has_many :game_players, dependent: :destroy 
  has_many :players, :through => :game_players #, :source => :player
  has_many :tricks, dependent: :destroy 

  validates :game_players, length:{maximum: 4}
  validates :tricks, length:{maximum: 10}



  def player_to_play(players)
    players[self.next_player-1]
  end

  def to_next_player
    case self.next_player
    when 0, 4
      self.next_player=1
     # self.round +=1
   when 1..3 
    self.next_player +=1
      #5 -> Trick ends
    else
      self.next_player = 0
    end
  end

  def clear_tricks
    if self.tricks.any?
      self.tricks.each do |trick|
        if trick.cards.any?
          trick.cards.each do |card|
            card.update!(trick: nil)
          end    
        end
        trick.destroy!
      end  
    end
  end


end

