class Card < ApplicationRecord
  before_save :check_max_cards_on_deck, :check_max_cards_on_hand, :check_max_cards_on_trick
  belongs_to :deck, optional: true
  belongs_to :hand, optional: true
  belongs_to :trick, optional: true

  validates_associated :deck, :hand, :trick
  #attr_accessor :name #, :order_value

#  enum status: [:published, :unpublished, :not_set]
  #enum suits: [:kreuz, :pik, :herz, :karo]
  
  enum card_values: {
    "Zehn" => 10,
    "Bube" => 2,
    "Dame" => 3,
    "Koenig" => 4,
    "Ass" => 11
  }



  CARDS = [
    "Herz_Zehn",
    "Kreuz_Dame",
    "Pik_Dame",
    "Herz_Dame",
    "Karo_Dame",
    "Kreuz_Bube",
    "Pik_Bube",
    "Herz_Bube",
    "Karo_Bube",
    "Karo_Ass",
    "Karo_Zehn",
    "Karo_Koenig",
    "Kreuz_Ass",
    "Kreuz_Zehn",
    "Kreuz_Koenig",
    "Pik_Ass",
    "Pik_Zehn",
    "Pik_Koenig",
    "Herz_Ass",
    "Herz_Koenig"
  ]

  def order_value
    CARDS.find_index(self.name)
    #byebug
  end

  def point_value
    Card.card_values.each do |name, value|
      if self.name.include? name
        return value
      end
    end    
  end

  def Card.get_cards
    CARDS
  end

  def path
    path = "media/images/cards/" + self.name + ".png"
  end


private

  def check_max_cards_on_deck
    if self.deck
      if self.deck.cards.count<40 
        return true #deck not full yet
      else #deck is full
        if self.id
          card = Card.find(self.id)
          if self.deck.cards.include? card #deck is full but card already belongs to deck
            return true
          else #deck is full and existing card can not be added
            errors.add(:base, "Ein Deck kann nur maximal 40 Karten haben!")
            throw :abort
          end
        else #deck is full and new card can not be added
          errors.add(:base, "Ein Deck kann nur maximal 40 Karten haben!")
          throw :abort
        end
      end
    else 
      return true #card without deck
    end
  end

  def check_max_cards_on_hand
    if self.hand
      if self.hand.cards.count<10 #|| self.hand.cards.include? self
        return true
      else
        if self.id
          card = Card.find(self.id)
          if self.hand.cards.include? card #hand is full but card already belongs to hand
            return true
          else #hand is full and existing card can not be added
            errors.add(:base, "Ein Spieler kann nur maximal 10 Karten auf der Hand haben!")
            throw :abort
          end
        else #hand is full and new card can not be added
          errors.add(:base, "Ein Spieler kann nur maximal 10 Karten auf der Hand haben!")
          throw :abort
        end
      end
    else 
      return true #card without hand
    end
  end

  def check_max_cards_on_trick
    if self.trick
      if self.trick.cards.count<4 #|| self.trick.cards.include? self
        return true
      else
        if self.id
          card = Card.find(self.id)
          if self.trick.cards.include? card #trick is full but card already belongs to trick
            return true
          else #trick is full and existing card can not be added
            errors.add(:base, "Ein Stick kann nur maximal 4 Karten haben!")
            throw :abort
          end
        else #trick is full and new card can not be added
          errors.add(:base, "Ein Stick kann nur maximal 4 Karten haben!")
          throw :abort
        end
      end
    else 
      return true #card without trick
    end
  end

end