class GamePlayer < ApplicationRecord

  belongs_to :player, optional: true
  belongs_to :game, optional: true
  
  has_one :hand, dependent: :destroy
  has_many :tricks, dependent: :destroy

	validates :tricks, length:{maximum: 10}

end
