class Deck < ApplicationRecord
 # include ActiveModel::Model
  has_many :cards, -> { order(Arel.sql('RANDOM()')) }, dependent: :destroy 
  belongs_to :game, optional: true

  validates :cards, length:{maximum: 40}

  def deal_to(hand)
    #cards = Card.where(deck: self)
    10.times do
      cards = Card.where(deck: self)
      i = rand(0..cards.count-1)
      card = cards[i] #cards.first
      #byebug
      card.update!(hand: hand, deck: nil)
      
      
    end
  end

  def build_deck
    Card.all.each do |card|
      card.update!(deck: self)
    end
  end

end
