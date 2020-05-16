class Card < ApplicationRecord

  #include ActiveModel::Model
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

end



