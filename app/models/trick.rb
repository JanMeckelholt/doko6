class Trick < ApplicationRecord
	belongs_to :game, optional: true
	belongs_to :game_player, optional: true
	has_many :cards

	validates :cards, length:{maximum: 4}
end
