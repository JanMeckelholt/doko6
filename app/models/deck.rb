class Deck < ApplicationRecord
 before_save :check_max_cards
 has_many :cards, -> { order(Arel.sql('RANDOM()')) }, dependent: :destroy 
 belongs_to :game, optional: true

 validates :cards, length:{maximum: 40}

 def deal_to(hand)
    #cards = Card.where(deck: self)
    10.times do
      cards = Card.where(hand: nil, deck: self)
      i = rand(0..cards.count-1)
      card = cards[i] #cards.first
      #byebug
      if card 
        card.update!(hand: hand, trick:nil, played: false)
      end
      
    end
  end

  def build_deck
    Card.all.each do |card|
      card.update!(deck: self, played: false, hand: nil, trick:nil)
    end
  end

  private
  
  def check_max_cards
    if self.cards.any?
      if self.cards.count<=40
        return true
      else
        errors.add(:base, "Deck kann nur maximal 40 Karten haben!")
        throw :abort
      end
    else
      return true
    end
  end

end
