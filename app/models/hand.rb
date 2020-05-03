class Hand < ApplicationRecord

  #include ActiveModel::Model
  #
  has_many :cards   #, -> { order(order_value) }  
  belongs_to :player, optional: true
 
  validates :cards, length:{maximum: 10}

   

  #attr_accessor :hand_cards

  #def initialize(player)
  #  @hand_cards = []
  #end

  #def add_card(card)
  #  @hand_cards << card
  #end

  #def play_card(card)
  #  @hand_cards.delete(card)
  #end

  #def hand_cards
  #  @hand_cards
  #end

  #def sort_cards
    #@hand_cards.sort! { |a, b| a.numeric_value <=> b.numeric_value }
  #  byebug
    
  #  @cards.sort_by! { |a| Deck.card(a)  }
  #end


  #def get_cards
  #  @cards = []
  #  @cards << self.card1
  #  @cards << self.card2
  #  @cards << self.card3
  #  @cards << self.card4
  #  @cards << self.card5
  #  @cards << self.card6
  #  @cards << self.card7
  #  @cards << self.card8
  #  @cards << self.card9
  #  @cards << self.card10
    #byebug
  #  @cards.sort_by! { |a| Deck.order_value(a)  }
  #end


  def sort_cards
    #@hand_cards.sort! { |a, b| a.numeric_value <=> b.numeric_value }
  #  byebug
    
    sef.cards.sort_by! { |a| a.order_value  }
  end





  private




  

end
