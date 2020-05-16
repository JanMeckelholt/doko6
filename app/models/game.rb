class Game < ApplicationRecord
  before_save :check_max_game_players, :check_max_tricks
  before_destroy :clear_tricks
  #include ActiveModel::Model
  has_one :deck, dependent: :destroy 

  #belongs_to :player
  has_many :game_players, dependent: :destroy 
  has_many :players, :through => :game_players #, :source => :player
  has_many :tricks, dependent: :destroy 

  #validates_length_of :game_players, maximum: 4
 # validates_length_of :tricks, maximum: 10



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

  def to_next_dealer
    case self.dealer
    when 0, 4
      self.dealer=1
    when 1..3 
      self.dealer +=1
    else
      self.dealer = 0
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

  private

  def check_max_game_players
    if self.game_players.any?
      if self.game_players.count<=4
        return true
      else
        errors.add(:base, "Spiel kann nur maximal 4 Spieler haben!")
        throw :abort
      end
    else
      return true
    end
  end

  def check_max_tricks
    if self.tricks.any?
      if self.tricks.count<=10
        return true
      else
        errors.add(:base, "Spiel kann nur maximal 10 Stiche haben!")
        throw :abort
      end
    else
      return true
    end
  end


end

