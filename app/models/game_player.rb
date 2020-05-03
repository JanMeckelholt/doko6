class GamePlayer < ApplicationRecord

  belongs_to :player, optional: true
  belongs_to :game, optional: true
  
end
