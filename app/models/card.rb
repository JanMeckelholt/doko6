class Card < ApplicationRecord

  #include ActiveModel::Model
  belongs_to :deck, optional: true
  belongs_to :hand, optional: true
  belongs_to :trick, optional: true

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

  #@@order = {
  #  [:herz, :zehn] => 1,
  #  [:kreuz, :dame]=> 2,
  #  [:pik, :dame] => 3,
  #  [:herz , :dame] => 4,
  #  [:karo , :dame] => 5,
  #  [:kreuz , :bube] => 6,
  #  [:pik , :bube] => 7,
  #  [:herz , :bube] => 8,
  #  [:karo , :bube] => 9,
  #  [:karo , :ass] => 10,
  #  [:karo , :zehn] => 11,
  #  [:karo , :koenig] => 12,
  #  [:kreuz , :ass] => 13,
  #  [:kreuz , :zehn] => 14,
  #  [:kreuz , :koenig] => 15,
  #  [:pik , :ass] => 16,
  #  [:pik , :zehn] => 17,
  #  [:pik , :koenig] => 18,
  #  [:herz , :ass] => 19,
  #  [:herz , :koenig] => 20
  #}



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
    CARDS.find_index(card)
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
  #def self.all_suits
  #  self.suits
  #end

  #def self.all_values
  #  self.values
  #end




end



