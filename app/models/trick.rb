class Trick < ApplicationRecord
	belongs_to :game, optional: true
	belongs_to :game_player, optional: true
	has_many :cards

	validates :cards, length:{maximum: 4}

	def value_sum
		sum = 0
		self.cards.each do |card|
			sum += card.point_value
		end
		return sum

	end

end
